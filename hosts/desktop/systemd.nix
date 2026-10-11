{ ... }: {
  imports = [
    ../../modules/systemd/system/acpid.nix
  ];

  systemd = {
    # NOTE: Disable coredumps to prevent harmful log exposure
    coredump.enable = false;
  };
}
