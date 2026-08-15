{ ... }: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;

    # Prefer or enforce wayland applications
    # TODO: Review what this actually does underneath
    xwayland.enable = false;
  };
}
