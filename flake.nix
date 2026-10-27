{
  description = "Unified nix flake nixos config";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # NOTE: used for Hyprland/Nixvim
    systems.url = "github:nix-systems/default/main";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    noctalia.url = "github:noctalia-dev/noctalia/cachix";

    nixvim = {
      url = "github:nix-community/nixvim";

      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        flake-parts.follows = "flake-parts";
      };
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { withSystem, ... }: {
        systems = import inputs.systems;

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

          formatter = pkgs.nixfmt;
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
