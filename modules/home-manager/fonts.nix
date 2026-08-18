{ pkgs, ... }: {
  home.packages = with pkgs; [
    nerd-fonts.proggy-clean-tt
    nerd-fonts.space-mono
  ];
}
