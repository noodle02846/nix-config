{ ... }: {
  security = {
    # Extra kernel protections
    #
    # NOTE: lockKernelModules causes mullvad to fail
    #       to load its own internal nftables module
    #       implicitly, and must be declared manually
    # HACK: Disable until a fix is found or more time
    #       is spent on debugging (likely not)

    lockKernelModules = false;
    protectKernelImage = true;

    # NOTE: Already on CPU without multi-threading
    #       newer CPUs would increase IPC gains anyway
    allowSimultaneousMultithreading = false;

    # Used for PipeWire
    rtkit.enable = true;

    # Implicitly trust all guests
    virtualisation.flushL1DataCache = "never";

    # SUID/Elevation wrappers
    sudo.enable = false;
    run0.wheelNeedsPassword = true;

    doas = {
      enable = true;
      wheelNeedsPassword = true;
    };

    # TODO: Setup AppArmor MAC with granular profiles
    # apparmor = {};
  };
}
