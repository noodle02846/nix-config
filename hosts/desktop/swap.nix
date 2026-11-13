_: {
  boot.kernel.sysctl = {
    # NOTE: Recommended zram swap settings
    "vm.swappiness" = 200;
    "vm.page-cluster" = 0;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
  };

  zramSwap = {
    enable = true;
    priority = 10;
    memoryPercent = 50;
  };

  # swapDevices = [
  #   {
  #     device = "/dev/disk/by-partuuid/97af6585-79ab-4eaa-8a3f-5bd599d03e04";
  #
  #     priority = 1;
  #     randomEncryption.enable = true;
  #   }
  # ];
}
