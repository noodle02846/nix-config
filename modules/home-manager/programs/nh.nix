{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    nh
  ];

  programs.nh = {
    enable = true;
    flake = "${config.home.homeDirectory}/nix-config";

    clean = {
      # NOTE: Keep disabled until further review and benefit
      #       over using regular nix.gc
      enable = false;
      dates = "04:00";
      # extraArgs = "--keep 10 --keep-since 30d";
    };
  };
}
