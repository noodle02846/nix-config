{ lib, ... }: {
  imports = [
    ./boot.nix
    ./time.nix
    ./users.nix
    ./console.nix
    ./hardware.nix
    ./security.nix
    ./networking.nix
    ./environment.nix

    ../../modules/nixos/programs/zsh.nix
    ../../modules/nixos/programs/steam.nix
    ../../modules/nixos/programs/hyprland.nix

    ../../modules/nixos/services/ntpd.nix
    ../../modules/nixos/services/xserver.nix
    ../../modules/nixos/services/mullvad.nix
    ../../modules/nixos/services/pipewire.nix
  ];

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
      allowed-users = [ "@wheel" ];

      # Enable flakes + flakes specific nix commands (e.g. nix develop)
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      # Cachix settings
      substituters = [ "https://hyprland.cachix.org" ];

      trusted-users = [
        "root"
        "@wheel"
      ];

      trusted-substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
  };

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      # Steam related packages
      "steam"
      "steam-unwrapped"

      # NVIDIA specific drivers and utilities/programs
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
    ];

  system.stateVersion = "26.05";
}
