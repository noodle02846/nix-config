{ ... }: {
  systemd.services.mullvad-daemon = {
    serviceConfig = {
      Environment = [
        "TALPID_FORCE_USERSPACE_WIREGUARD=1"
      ];
    };
  };
}
