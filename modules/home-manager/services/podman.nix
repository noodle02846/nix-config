{ pkgs, ... }: {
  services.podman = {
    enable = true;
    enableTypeChecks = true;
  };

  xdg.configFile."containers/containers.conf.d/10-firewall.conf".source =
    (pkgs.formats.toml { }).generate "10-firewall.conf"
      { network.firewall_driver = "nftables"; };
}
