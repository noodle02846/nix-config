{ inputs, ... }: {
  flake.nixosConfigurations = {
    desktop = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        ../hosts/desktop
        inputs.sops.nixosModules.sops
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };

            users = {
              svc = ../users/svc;
              user = ../users/user;
            };
          };
        }
      ];

      specialArgs = { inherit inputs; };
    };
  };
}
