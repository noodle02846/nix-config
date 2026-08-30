{ config, ... }: {
  services.podman = {
    networks.gonic.driver = "bridge";

    containers.gonic = {
      image = "sentriz/gonic:latest";

      ports = [ "12100:8080" ];
      network = [ "gonic" ];

      autoStart = true;

      user = 10000;
      group = 10000;

      dropCapabilities = [ "all" ];

      extraPodmanArgs = [
        "--memory-reservation=32M"
      ];

      extraConfig = {
        Service = {
          CPUQuota = "150%";
          RestartSec = 30;
          StartLimitBurst = 3;
          StartLimitIntervalSec = 60;
        };

        Container = {
          Timezone = "UTC";

          # Unit hardening
          ReadOnly = true;
          ReadOnlyTmpfs = true;
          NoNewPrivileges = true;

          # Resource allocation
          Memory = "128M";
          PidsLimit = 64;
        };
      };

      environment = {
        GONIC_MUSIC_PATH = "/music";
        GONIC_CACHE_PATH = "/cache";
        GONIC_PODCAST_PATH = "/podcasts";
        GONIC_PLAYLISTS_PATH = "/playlists";

        GONIC_LISTEN_ADDR = "127.0.0.1:8080";

        GONIC_SCAN_INTERVAL = 60; # 60 Minutes
        GONIC_SCAN_WATCHER_ENABLED = true;
        GONIC_SCAN_AT_START_ENABLED = false;

        GONIC_TRANSCODE_CACHE_SIZE = 128; # 128MB
        GONIC_TRANSCODE_EJECT_INTERVAL = 60; # 60 Minutes
      };

      volumes =
        let
          directory = "${config.home.homeDirectory}/gonic";
        in
        [
          "${directory}/data:/data:rw"
          "${directory}/cache:/cache:rw"
          "${directory}/music:/music:ro"
          "${directory}/podcasts:/podcasts:rw"
          "${directory}/playlists:/playlists:rw"
        ];
    };
  };
}
