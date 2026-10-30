{ ... }: {
  security = {
    # Extra kernel protections
    lockKernelModules = true;
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

    run0 = {
      enable = true;
      enableSudoAlias = true;
      wheelNeedsPassword = true;

      persistentAuth.enable = true;
    };

    # Polkit
    polkit.settings.Polkitd.ExpirationSeconds = 60;

    # TODO: Setup AppArmor MAC with granular profiles
    # apparmor = {};
  };
}
