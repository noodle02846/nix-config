{ lib, ... }: {
  hardware = {
    graphics.enable = true;

    enableRedistributableFirmware = lib.mkForce true;

    # Previously set in hardware-configuration.nix
    cpu.intel.updateMicrocode = lib.mkForce true;

    # Enable NVIDIA drivers
    nvidia = {
      open = true;
      modesetting.enable = true;
    };

    # Enable Corsair drivers
    ckb-next = {
      enable = true;

      gid = 100;
    };
  };

  # Automatically generated hardware configuration:
  boot = {
    initrd = {
      kernelModules = [ ];
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
    };

    extraModulePackages = [ ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/70f94fce-53bf-43b5-9ccf-f5159d4258c8";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/355E-34CC";
      fsType = "vfat";

      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
