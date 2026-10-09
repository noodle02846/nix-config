{ pkgs, lib, ... }: {
  programs.discord = {
    enable = true;
    package = pkgs.discord.override {
      withOpenASAR = true;
      withVencord = true;
    };

    settings = {
      SKIP_HOST_UPDATE = true;
      SKIP_MODULE_UPDATE = true;

      BACKGROUND_COLOR = "#000000";

      openH264Enabled = true;
      trayBalloonShown = true;
      offloadAdmControls = true;

      DESKTOP_TTI_DNSTCP_WARMUP = true;
      DESKTOP_TTI_SPLASH_USE_WEBP = true;
      DESKTOP_TTI_UPDATE_BACKOFF_MAX_MS = 30000;

      chromiumSwitches = { };

      IS_MAXIMIZED = true;
      IS_MINIMIZED = false;

      WINDOW_BOUNDS = {
        x = 0;
        y = 0;
        width = 1920;
        height = 1080;
      };

      openasar = {
        setup = true;
        quickstart = true;
      };
    };
  };

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
      "discord-unwrapped"
    ];
}
