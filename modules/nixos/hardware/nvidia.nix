{ lib, ... }: {
  flake.modules.nixos.nvidia =
    { config, ... }:
    let
      cfg = config.noodle.hardware.nvidia;
    in
    {
      options.noodle.hardware.nvidia.enable = lib.mkEnableOption ''
        Enable NVIDIA drivers and unfree packages
      '';

      config = lib.mkIf cfg.enable {
        hardware.nvidia = {
          open = true;
          nvidiaSettings = false;
        };

        services.xserver.videoDrivers = [ "nvidia" ];
        nixpkgs.config.allowUnfreePackages = [ "nvidia-x11" ];
      };
    };
}
