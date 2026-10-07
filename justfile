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
