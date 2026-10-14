{ ... }: {
  imports = [
    ../../modules/systemd/system/acpid.nix
    ../../modules/systemd/system/ckb-next.nix
  ];

  systemd = {
    # NOTE: Disable coredumps to prevent harmful log exposure
    coredump.enable = false;
  };
}
