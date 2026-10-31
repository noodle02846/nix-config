{ ... }: {
  imports = [
    ../../modules/systemd/system/acpid.nix
    ../../modules/systemd/system/ckb-next.nix
    ../../modules/systemd/system/mullvad-daemon.nix
  ];

  systemd = {
    # NOTE: Enable coredumps and set storage to `none` to prevent log exposure
    coredump = {
      enable = true;

      settings.Coredump = {
        Storage = "none";
        ProcessSizeMax = 0;
      };
    };
  };
}
