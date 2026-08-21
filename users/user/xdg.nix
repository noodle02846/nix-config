{ config, ... }: {
  xdg = {
    enable = true;

    userDirs =
      let
        homeDir = "${config.home.homeDirectory}";
      in
      {
        createDirectories = true;

        desktop = "${homeDir}/desktop";

        projects = "${homeDir}/projects";
        documents = "${homeDir}/documents";

        download = "${homeDir}/downloads";

        music = "${homeDir}/music";
        pictures = "${homeDir}/pictures";
        videos = "${homeDir}/videos";

        publicShare = null;
        templates = null;
      };
  };
}
