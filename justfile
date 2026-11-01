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

build:
    @nh os build

boot:
    @nh os boot

test:
    @nh os test

generate-git-review out="/tmp/git-review.txt":
    @sh scripts/git-review.sh "{{ out }}"
