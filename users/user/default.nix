{ ... }: {
  imports = [
    ../../modules/home-manager/fonts.nix

    ../../modules/home-manager/desktop/hyprland.nix

    ../../modules/home-manager/programs/zsh.nix
    ../../modules/home-manager/programs/git.nix
    ../../modules/home-manager/programs/foot.nix
    ../../modules/home-manager/programs/tldr.nix
    ../../modules/home-manager/programs/neovim.nix

    ../../modules/home-manager/programs/chromium.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "user";
    homeDirectory = "/home/user";
    stateVersion = "26.05";
  };
}
