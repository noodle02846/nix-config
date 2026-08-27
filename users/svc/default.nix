{ ... }: {
  imports = [
    ../../modules/home-manager/services/podman.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "svc";
    homeDirectory = "/home/svc";
    stateVersion = "26.05";
  };
}
