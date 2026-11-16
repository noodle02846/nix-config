{
  description = "Unified nix flake nixos config";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";

    systems = {
      url = "github:nix-systems/default/main";
      flake = false;
    };

    treefmt = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
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

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
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
        inputs.treefmt.flakeModule
        inputs.git-hooks.flakeModule
      ];

      systems = import inputs.systems;

      perSystem =
        {
          config,
          lib,
          pkgs,
          ...
        }:
        {
          devShells.default = pkgs.mkShellNoCC {
            shellHook = "${config.pre-commit.shellHook}";

            nativeBuildInputs =
              with pkgs;
              [
                # LSPs
                nixd
                just-lsp
                bash-language-server

                # Secrets tooling
                age
                sops
              ]
              ++ [
                config.treefmt.build.wrapper
              ]
              ++ (lib.attrValues config.treefmt.build.programs);
          };

          pre-commit.settings.hooks.treefmt.enable = true;

          treefmt.programs = {
            # Flake tooling
            jq.enable = true;
            just.enable = true;

            # Markdown tooling
            mdformat.enable = true;

            # Shell tooling
            shfmt.enable = true;
            shellcheck = {
              enable = true;
              excludes = [ "*.envrc" ];
            };

            # Nix tooling
            nixfmt.enable = true;
            statix.enable = true;
            deadnix.enable = true;
          };
        };

      flake.nixosConfigurations."desktop" = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/desktop
          inputs.sops-nix.nixosModules.sops
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
