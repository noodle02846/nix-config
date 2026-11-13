#!/bin/sh
set -eu
out=${1:-/tmp/boot-review.txt}
umask 077
tmp=$(mktemp /tmp/boot-review.XXXXXX)
trap 'rm -f "$tmp"' 0 HUP INT TERM
section() { printf '\n=== %s ===\n' "$1"; }
set +e
{
  section "SYSTEM"; date; who -b; uname -a; cat /etc/os-release
  section "BOOT"; cat /proc/cmdline; systemd-analyze time
  section "CRITICAL CHAIN"; systemd-analyze critical-chain
  section "SLOWEST SERVICES"; systemd-analyze blame | grep '\.service$' | head -n 25
  section "FAILED UNITS"; systemctl --failed --no-pager
  section "ACTIVE JOBS"; systemctl list-jobs --no-pager
  section "EARLIEST CURRENT-BOOT WARNINGS (150)"
  journalctl -b -p warning --no-pager -o short-monotonic | head -n 150
  section "EARLIEST PREVIOUS-BOOT ERRORS (100)"
  journalctl -b -1 -p err --no-pager -o short-monotonic | head -n 100
} >"$tmp" 2>&1
set -e
mv "$tmp" "$out"
trap - 0 HUP INT TERM
printf 'wrote %s\n' "$out"
