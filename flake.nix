{
  description = "Unified nix flake for nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
        };
      };

      homeConfigurations = {
        "user" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [ ];
          extraSpecialArgs = { inherit inputs; };
        };
      };
    };
}
