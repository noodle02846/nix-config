{ config, ... }: {
  imports = [
    # Modules
    ../../modules/home-manager/fonts.nix

    ../../modules/home-manager/desktop/hyprland.nix
    ../../modules/home-manager/desktop/noctalia.nix

    ../../modules/home-manager/programs/nh.nix
    ../../modules/home-manager/programs/zsh.nix
    ../../modules/home-manager/programs/git.nix
    ../../modules/home-manager/programs/foot.nix
    ../../modules/home-manager/programs/tldr.nix
    ../../modules/home-manager/programs/neovim.nix
    ../../modules/home-manager/programs/direnv.nix
    ../../modules/home-manager/programs/posting.nix
    ../../modules/home-manager/programs/pi-coding-agent.nix

    ../../modules/home-manager/programs/discord.nix
    ../../modules/home-manager/programs/chromium.nix
    ../../modules/home-manager/programs/tor-browser.nix
    ../../modules/home-manager/programs/prismlauncher.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "user";
    homeDirectory = "/home/user";
    stateVersion = "26.05";
  };

  xdg = {
    enable = true;

    userDirs =
      let
        homeDir = "${config.home.homeDirectory}";
      in
      {
        enable = true;
        createDirectories = true;

        desktop = "${homeDir}/desktop";

        projects = "${homeDir}/projects";
        documents = "${homeDir}/documents";
        templates = "${homeDir}/templates";

        publicShare = "${homeDir}/public";
        download = "${homeDir}/downloads";

        music = "${homeDir}/music";
        pictures = "${homeDir}/pictures";
        videos = "${homeDir}/videos";
      };
  };
}
