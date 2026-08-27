{ pkgs, ... }: {
  home.packages = with pkgs; [
    podman
  ];

  services.podman = {
    enable = true;
    enableTypeChecks = true;
  };
}
