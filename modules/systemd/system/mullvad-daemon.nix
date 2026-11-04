{ pkgs, ... }: {
  # HACK: Fixes failure to create needed cgroups for split tunneling
  # TODO: Remove when 2026.6 or higher is released with cgroup v2
  systemd.services.mullvad-net-cls = {
    description = "Create Mullvad split-tunnel cgroup (net_cls child)";

    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;

      ExecStart = [
        "${pkgs.coreutils}/bin/mkdir -p /sys/fs/cgroup/net_cls"
        "${pkgs.util-linux}/bin/mount -t cgroup -o net_cls cgroup /sys/fs/cgroup/net_cls"
        "${pkgs.coreutils}/bin/mkdir -p /sys/fs/cgroup/net_cls/mullvad-exclusions"
      ];
      ExecStop = [
        "-${pkgs.util-linux}/bin/umount /sys/fs/cgroup/net_cls"
        "-${pkgs.coreutils}/bin/rmdir /sys/fs/cgroup/net_cls"
      ];
    };
  };

  systemd.services.mullvad-daemon = {
    wants = [ "mullvad-net-cls.service" ];
    after = [ "mullvad-net-cls.service" ];

    environment = {
      TALPID_FORCE_USERSPACE_WIREGUARD = "1";
    };

    serviceConfig =
      let
        serviceName = "mullvad-vpn";
      in
      {
        ProtectSystem = "strict";
        ProtectProc = "default";
        ProtectClock = true;
        ProtectHome = true;
        ProtectHostname = true;
        ProtectKernelLogs = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true; # NOTE: Causes `Failed to apply src_valid_mark: Read-only file system (os error 30)` when turned on
        # ProtectControlGroups = "private";

        PrivateMounts = true;
        # PrivateDevices = true;
        PrivateIPC = true;
        PrivatePIDs = true;
        PrivateTmp = true;
        # PrivateUsers = true;

        RestrictAddressFamilies = [
          "AF_UNIX"
          "AF_NETLINK"
          "AF_INET"
          "AF_INET6"
        ];
        RestrictRealtime = true;
        RestrictNamespaces = true;
        RestrictSUIDSGID = true;

        RemoveIPC = true;

        # RuntimeDirectory = "${serviceName}";
        StateDirectory = "${serviceName}";
        LogsDirectory = "${serviceName}";
        CacheDirectory = "${serviceName}";
        WorkingDirectory = "/var/lib/${serviceName}";

        # BindPaths = [ "/dev/net/tun" ];
        BindReadOnlyPaths = [ builtins.storeDir ];

        ExecPaths = [ builtins.storeDir ];
        NoExecPaths = [ "/" ];

        ReadWritePaths = [
          "/etc/resolv.conf"
          "/etc/${serviceName}"
          "/sys/fs/cgroup/net_cls"
          # "/var/log/${serviceName}"
          # "/var/lib/${serviceName}"
          # "/var/cache/${serviceName}"
        ];
        UMask = "0007";

        DevicePolicy = "closed";
        DeviceAllow = [ "/dev/net/tun rw" ];

        # DynamicUser = true;
        LockPersonality = true;
        NoNewPrivileges = true;
        # ProcSubset = "pid";

        CapabilityBoundingSet = [
          "CAP_NET_ADMIN"
          "CAP_NET_RAW"
        ];

        SystemCallErrorNumber = "EPERM";
        SystemCallFilter = [
          "@system-service"
          "~@resources"
          "~@privileged"
        ];
        SystemCallArchitectures = "native";

        MemoryDenyWriteExecute = true;
      };
  };
}
