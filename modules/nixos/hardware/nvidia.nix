_: {
  hardware.nvidia = {
    open = true;
    nvidiaSettings = false;
  };

  services.xserver.videoDrivers = [
    "nvidia"
  ];

  nixpkgs.config.allowUnfreePackages = [
    "nvidia-x11"
  ];
}
