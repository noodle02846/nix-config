default:
    @just --list

update:
    @nix flake update

check:
    @nix flake check

home:
    @nh home switch

switch:
    @nh os switch

generate-git-review out="/tmp/git-review.txt":
    @sh scripts/git-review.sh "{{ out }}"
