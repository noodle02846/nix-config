{ ... }: {
  services.mullvad-vpn = {
    enable = true;

    enableExcludeWrapper = true;
    enableEarlyBootBlocking = true;
  };
}
