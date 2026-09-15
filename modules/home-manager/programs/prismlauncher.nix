{ pkgs, ... }: {
  home.packages = with pkgs; [
    prismlauncher
  ];

  programs.prismlauncher = {
    enable = true;
  };
}
