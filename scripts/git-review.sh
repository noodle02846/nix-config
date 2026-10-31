#1/usr/bin/sh

set -euo pipefail

die() { printf 'error: %s\n' "$1" >&2; exit 1; }

command -v git >/dev/null 2>&1 || die "git not found"
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || die "not inside a git work tree"
cd "$(git rev-parse --show-toplevel)"

# ---- knobs (env-overridable) ---------------------------------------------
OUT="${1:-${OUT:-/tmp/review.txt}}"   # target file
COMMITS="${COMMITS:-15}"             # detailed log --stat entries
ONELINE="${ONELINE:-50}"             # compact history length
PATCHES="${PATCHES:-5}"              # format-patch, last N commits (0 = off)
INCLUDE_LOCK="${INCLUDE_LOCK:-0}"    # 1 = dump flake.lock verbatim
MAX_BYTES="${MAX_BYTES:-262144}"     # skip single files larger than this

# ---- which files to dump ---------------------------------------------------
GLOBS=('*.nix' '.sops.yaml' 'justfile' 'Justfile' '*.md')
EXCLUDES=('secrets/*' '*.age' '*.lock' 'flake.lock')  # adjust secrets/* to your layout

PATHSPECS=()
for g in "${GLOBS[@]}";     do PATHSPECS+=("$g"); done
for e in "${EXCLUDES[@]}"; do PATHSPECS+=(":(exclude)$e"); done
mapfile -t FILES < <(git ls-files -- "${PATHSPECS[@]}" | sort)

HAS_COMMITS=1
git rev-parse HEAD >/dev/null 2>&1 || HAS_COMMITS=0

LINE=$(printf '#%.0s' {1..80})
section() { printf '%s\n## %s\n%s\n\n' "$LINE" "$1" "$LINE"; }

# ---- generate ---------------------------------------------------------------
exec 3>&1 1>"$OUT"

section "REPO METADATA"
printf 'generated : %s\n' "$(date '+%Y-%m-%d %H:%M %Z')"
printf 'repo      : %s\n' "$(git rev-parse --show-toplevel)"
printf 'remote    : %s\n' "$(git remote get-url origin 2>/dev/null || echo '(none)')"
printf 'branch    : %s\n' "$(git branch --show-current 2>/dev/null || echo '(detached)')"
printf 'upstream  : %s\n' "$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null || echo '(none)')"
printf 'HEAD      : %s\n' "$(git rev-parse HEAD 2>/dev/null || echo '(no commits)')"
printf 'describe  : %s\n' "$(git describe --tags --always 2>/dev/null || echo '(n/a)')"
printf 'work tree : %s\n' "$( [ -n "$(git status --porcelain 2>/dev/null)" ] && echo dirty || echo clean )"
printf '\n'

section "BUNDLE MANIFEST"
printf 'file dumps included (%s):\n' "${#FILES[@]}"
for f in "${FILES[@]}"; do printf '  %s\n' "$f"; done
printf '\nnote: untracked files are listed by name only; contents are never dumped.\n\n'

section "GIT STATUS (porcelain v1, with branch)"
git status --porcelain=v1 --branch 2>/dev/null || true
printf '\n'

section "WORKING TREE DIFF (git diff HEAD)"
if [ "$HAS_COMMITS" = 1 ]; then git diff HEAD; else echo '(no commits)'; fi
printf '\n'

section "PATCHES (git format-patch, last ${PATCHES})"
if [ "$PATCHES" -gt 0 ] && [ "$HAS_COMMITS" = 1 ]; then
    git format-patch -"$PATCHES" --stdout --no-signature || echo '(none)'
else
    echo '(disabled or no commits)'
fi
printf '\n'

section "GIT LOG — compact (last ${ONELINE})"
if [ "$HAS_COMMITS" = 1 ]; then
    git log --oneline --decorate -n "$ONELINE" || true
else
    echo '(no commits)'
fi
printf '\n'

section "GIT LOG — detailed with stats (last ${COMMITS})"
if [ "$HAS_COMMITS" = 1 ]; then
    git log --stat -n "$COMMITS" || true
else
    echo '(no commits)'
fi
printf '\n'

section "FLAKE INPUTS"
if [ -f flake.lock ]; then
    if command -v jq >/dev/null 2>&1; then
        jq -r '.nodes.root.inputs // {} | to_entries[] | "\(.key) -> \(.value)"' flake.lock
    else
        echo '(jq not available — set INCLUDE_LOCK=1 to dump the raw lock)'
    fi
else
    echo '(no flake.lock)'
fi
printf '\n'

if [ "$INCLUDE_LOCK" = 1 ] && [ -f flake.lock ]; then
    section "FLAKE.LOCK (verbatim)"
    cat flake.lock
    printf '\n'
fi

section "TRACKED FILES (${#FILES[@]} files)"
for f in "${FILES[@]}"; do
    size=$(stat -c%s "$f" 2>/dev/null || echo 0)
    if [ "$size" -gt "$MAX_BYTES" ]; then
        printf '%s\n\n' "---------- BEGIN FILE: $f (SKIPPED: ${size} bytes > MAX_BYTES) ----------"
        continue
    fi
    printf '%s\n' "---------- BEGIN FILE: $f ----------"
    cat "$f"
    printf '%s\n\n' "---------- END FILE: $f ----------"
done
[ "${#FILES[@]}" -gt 0 ] || echo '(no files matched GLOBS)'

exec 1>&3 3>&-
printf 'wrote %s (%s bytes, %s files dumped)\n' "$OUT" "$(wc -c <"$OUT")" "${#FILES[@]}"
