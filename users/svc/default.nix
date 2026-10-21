{ ... }: {
  imports = [
    ../../modules/home-manager/services/podman.nix

    ../../modules/home-manager/containers/gonic.nix
    ../../modules/home-manager/containers/silverbullet.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "svc";
    homeDirectory = "/home/svc";
    stateVersion = "26.05";
  };
}
