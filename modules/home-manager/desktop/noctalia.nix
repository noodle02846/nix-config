{ inputs, ... }: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;

    settings = {
      theme = {
        mode = "dark";
      };

      wallpaper.enabled = false;
    };
  };
}
