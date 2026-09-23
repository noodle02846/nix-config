{
  description = "Unified nix flake nixos config";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";

    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    noctalia.url = "github:noctalia-dev/noctalia/cachix";

    nixvim.url = "github:nix-community/nixvim";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { withSystem, ... }: {
        systems = [ "x86_64-linux" ];

        perSystem = { pkgs, ... }: {
          devShells.default = pkgs.mkShellNoCC {
            buildInputs = with pkgs; [
              # Runners, LSP, Formatters, and Linters

              nixd
              nixfmt
              statix

              just
              just-lsp
            ];
          };
        };

        flake = {
          nixosConfigurations."desktop" = inputs.nixpkgs.lib.nixosSystem {
            modules = [
              ./hosts/desktop
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = { inherit inputs; };

                  users.svc = ./users/svc;
                };
              }
            ];

            specialArgs = { inherit inputs; };
          };

          homeConfigurations."user" = withSystem "x86_64-linux" (
            { pkgs, ... }:
            inputs.home-manager.lib.homeManagerConfiguration {
              inherit pkgs;

              modules = [ ./users/user ];
              extraSpecialArgs = { inherit inputs; };
            }
          );
        };
      }
    );
}
