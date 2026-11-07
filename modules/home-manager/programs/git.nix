{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    git
  ];

  programs.git = {
    enable = true;

    settings = {
      init.defaultBranch = "main";

      user = {
        name = "Noodle";
        email = "115919945+noodle02846@users.noreply.github.com";
        signingKey = "${config.home.homeDirectory}/.ssh/git_signing_desktop_ed25519.pub";
      };

      gpg.format = "ssh";
      commit.gpgSign = true;
    };
  };
}
