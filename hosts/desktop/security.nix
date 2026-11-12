_: {
  security = {
    # Extra kernel protections
    lockKernelModules = true;
    protectKernelImage = true;

    # NOTE: Already on CPU without multi-threading
    #       newer CPUs would increase IPC gains anyway
    allowSimultaneousMultithreading = false;

    # Used for PipeWire
    rtkit.enable = true;

    # NOTE: Untrusted guests planned
    virtualisation.flushL1DataCache = "always";

    # SUID/Elevation wrappers
    sudo.enable = false;

    run0 = {
      enable = true;
      wheelNeedsPassword = true;

      sudo-shim.enable = true;
      persistentAuth.enable = true;
    };

    # Polkit
    polkit = {
      enable = true;
      settings.Polkitd.ExpirationSeconds = 60;
    };

    # TODO: Setup AppArmor MAC with granular profiles
    # apparmor = {};
  };
}
