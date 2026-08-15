{ ... }: {
  services.xserver = {
    enable = false; # Explicitly disallow
    videoDrivers = [ "nvidia" ];
  };
}
