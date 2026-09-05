{ inputs, pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      vim # Editor
      tmux # Terminal multiplexer
      bottom # System/process resource monitor
      dust # File/disk size utility
      pciutils # PCI inspection utility
      usbutils # USB inspection utility

      # Extras
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    shells = with pkgs; [
      zsh
    ];

    sessionVariables = {
      "NIXOS_OZONE_WL" = "1";
    };
  };
}
