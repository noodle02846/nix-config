{ ... }: {
  imports = [
    ../../modules/systemd/system/acpid.nix
    ../../modules/systemd/system/ckb-next.nix
  ];

  systemd = {
    # NOTE: Disable coredumps to prevent harmful log exposure
    # HACK: Keep enabled to prevent coredumps being sent to my home folder
    # coredump.enable = true;
  };
}
