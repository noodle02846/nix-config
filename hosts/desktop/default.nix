_: {
  imports = [
    ./sops.nix
    ./boot.nix
    ./swap.nix
    ./time.nix
    ./users.nix
    ./console.nix
    ./systemd.nix
    ./hardware.nix
    ./security.nix
    ./networking.nix
    ./environment.nix

    ../../modules/nixos/desktop/uwsm.nix
    ../../modules/nixos/desktop/hyprland.nix

    ../../modules/nixos/programs/zsh.nix
    ../../modules/nixos/programs/steam.nix

    ../../modules/nixos/services/ntpd.nix
    ../../modules/nixos/services/greetd.nix
    ../../modules/nixos/services/mullvad.nix
    ../../modules/nixos/services/pipewire.nix
  ];

  noodle = {
    hardware = {
      nvidia.enable = true;
    };
  };

  nix = {
    gc = {
      automatic = true;
      persistent = true;

      options = "--delete-older-than 30d";

      dates = [ "04:00" ];
      randomizedDelaySec = "30min";
    };

    optimise = {
      automatic = true;
      persistent = true;

      dates = [ "04:30" ];
      randomizedDelaySec = "30min";
    };

    settings = {
      # Replace default "*", allowing all users
      allowed-users = [
        "user"
        "svc"
      ];

      trusted-users = [ "root" ];

      # Enable flakes + flakes specific nix commands (e.g. nix develop)
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
    };
  };

  # HACK: Move declaration to system module to bypass `useGlobalPkgs`
  nixpkgs.config.allowUnfreePackages = [
    "discord"
    "discord-unwrapped"
  ];

  system.stateVersion = "26.05";
}
