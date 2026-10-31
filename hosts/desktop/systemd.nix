{ lib, ... }: {
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

    # NOTE: Service account does not need to be ready to login to
    services.home-manager-svc = {
      before = lib.mkForce [ "user@10000.service" ];
      wantedBy = lib.mkForce [ "user@10000.service" ];
    };
  };
}
