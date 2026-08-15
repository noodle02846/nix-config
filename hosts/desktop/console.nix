{ pkgs, ... }: {
  console = {
    earlySetup = true;

    packages = with pkgs; [
      terminus_font
    ];

    font = "${pkgs.terminus_font}/share/consolefonts/ter-u16n.psf.gz";

    # TODO: Review console colors
    colors = [
      # Normal colors
      "080808"
      "D70000"
      "789978"
      "FFAA88"
      "7788AA"
      "D7007D"
      "708090"
      "DEEEED"

      # Bright colors
      "444444"
      "D70000"
      "789978"
      "FFAA88"
      "7788AA"
      "D7007D"
      "708090"
      "DEEEED"
    ];
  };
}
