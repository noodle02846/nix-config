{ pkgs, inputs, ... }: {
  programs.hyprland =
    let
      system = pkgs.stdenv.hostPlatform.system;
    in
    {
      enable = true;
      withUWSM = true;

      # Prefer or enforce wayland applications
      # TODO: Review what this actually does underneath
      # HACK: Enable for now as it breaks steam
      xwayland.enable = true;

      # Use flake inputs
      package = inputs.hyprland.packages.${system}.hyprland;
      portalPackage = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
    };
}
