{ config, ... }: {
  services.podman = {
    networks.silverbullet.driver = "bridge";

    containers.silverbullet = {
      image = "ghcr.io/silverbulletmd/silverbullet:2.12.1-slim@sha256:7e24c16d31a3f4b4a4832ed64ec585e605a1e275b7c35917d385176f0b40415c";

      userNS = "keep-id";

      ports = [ "12110:8080" ];
      network = [ "silverbullet" ];

      autoStart = true;

      user = 10000;
      group = 10000;

      dropCapabilities = [ "all" ];

      extraPodmanArgs = [ ]; # Memory reservation

      extraConfig = {
        Service = { };

        Container = {
          Timezone = "UTC";
        };
      };

      environment = {
        SB_HOSTNAME = "0.0.0.0";
        SB_PORT = 8080;
      };

      volumes = [
        "${config.home.homeDirectory}/silverbullet/data:/data:rw,U"
      ];
    };
  };
}
