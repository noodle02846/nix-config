{ ... }: {
  networking = {
    hostName = "desktop";

    nameservers = [
      # Quad9
      "9.9.9.9"
      "149.112.112.112"

      # Mullvad DNS
      "192.242.2.6" # extended.dns.mullvad.net
      "192.242.2.4" # base.dns.mullvad.net
    ];

    enableIPv6 = false;

    nftables.enable = true;
    networkmanager.enable = false;

    dhcpcd = {
      enable = true;
      allowSetuid = false;

      extraConfig = ''
        nohook resolv.conf
      '';
    };

    firewall = {
      enable = true;

      interfaces."eno1" = {
        allowedUDPPorts = [
          7359 # Jellyfin discovery port
        ];

        allowedTCPPorts = [
          # NOTE: not enabled for security and due to
          #       missing OpenSSH hardened configurations
          # 22 # SSH port
          8096 # Jellyfin web port
          12100 # Custom gonic (Open Subsonic) server port
        ];
      };
    };
  };
}
