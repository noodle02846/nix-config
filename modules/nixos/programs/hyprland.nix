{ ... }: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;

    # Prefer or enforce wayland applications
    # TODO: Review what this actually does underneath
    # HACK: Enable for now as it breaks steam
    xwayland.enable = true;
  };
}
