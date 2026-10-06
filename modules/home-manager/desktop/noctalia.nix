{ inputs, ... }: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;
    systemd.enable = true;

    settings = {
      theme = {
        mode = "dark";
        shell_mode = "follow";

        source = "wallpaper";
        wallpaper_scheme = "m3-monochrome";
      };

      shell = {
        setup_wizard_enabled = false;

        font_family = "SpaceMono Nerd Font Mono";

        # NOTE: Preferred native method over launch_apps_custom_command
        #       and achieves the same effect of `uwsm app -- $CMD`
        launch_apps_as_systemd_services = true;

        clipboard_enabled = false;

        panel = {
          transparency_mode = "glass";
        };

        launcher = {
          categories = false;

          compact = true;
          app_grid = true;
        };
      };

      bar.default = {
        position = "left";

        radius = 50;

        concave_edge_corners = false;

        margin_edge = 10;

        widget_spacing = 10;
      };

      wallpaper = {
        enabled = true;
        fill_mode = "crop";
      };

      nightlight = {
        enable = true;

        temperature_day = 6000;
        temperature_night = 4500;
      };
    };
  };
}
