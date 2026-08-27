{
  description = "Unified nix flake nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim";

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs =
    inputs@{ nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      nixosConfigurations = {
        "desktop" = nixpkgs.lib.nixosSystem {
          modules = [ ./hosts/desktop ];
          specialArgs = { inherit inputs; };
        };
      };

      homeConfigurations = {
        "user" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [ ./users/user ];
          extraSpecialArgs = { inherit inputs; };
        };

        "svc" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [ ./users/svc ];
          extraSpecialArgs = { inherit inputs; };
        };
      };
    };
}
