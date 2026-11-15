{
  description = "Unified nix flake nixos config";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";

    systems = {
      url = "github:nix-systems/default/main";
      flake = false;
    };

    git-hooks = {
      url = "github:cachix/git-hooks.nix";

      inputs = {
        flake-compat.follows = "";
        nixpkgs.follows = "nixpkgs";
      };
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.git-hooks.flakeModule
      ];

      systems = import inputs.systems;

      perSystem = { config, pkgs, ... }: {
        devShells.default = pkgs.mkShellNoCC {
          shellHook = "${config.pre-commit.shellHook}";

          packages =
            config.pre-commit.settings.enabledPackages
            ++ (with pkgs; [
              just
              just-lsp

              jq
            ]);
        };

        pre-commit.settings.hooks = {
          deadnix.enable = true;
          nixfmt.enable = true;
          statix.enable = true;
        };
      };

      flake.nixosConfigurations."desktop" = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/desktop
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };

              users = {
                svc = ./users/svc;
                user = ./users/user;
              };
            };
          }
        ];

        specialArgs = { inherit inputs; };
      };
    };
}
