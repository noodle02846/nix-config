{ pkgs, ... }: {
  home.packages = with pkgs; [
    foot
  ];

  # TODO: Evaluate using Ghostty or Alacritty instead of foot
  programs.foot = {
    enable = true;

    # NOTE: Minimally decreases memory usage compared to full terminal windows
    server.enable = true;

    settings = {
      main = {
        font = "ProggyClean Nerd Font Mono:size=12";
      };

      cursor = {
        blink = "yes";
        beam-thickness = 1;
      };

      colors-dark = {
        alpha = 0.5;

        foreground = "DEEEED";
        background = "0A0A0A";

        regular0 = "080808";
        regular1 = "D70000";
        regular2 = "789978";
        regular3 = "FFAA88";
        regular4 = "7788AA";
        regular5 = "D7007D";
        regular6 = "708090";
        regular7 = "DEEEED";

        bright0 = "444444";
        bright1 = "D70000";
        bright2 = "789978";
        bright3 = "FFAA88";
        bright4 = "7788AA";
        bright5 = "D7007D";
        bright6 = "708090";
        bright7 = "DEEEED";

        selection-foreground = "DEEEED";
        selection-background = "7A7A7A";

        urls = "D7007D";
      };
    };
  };
}
