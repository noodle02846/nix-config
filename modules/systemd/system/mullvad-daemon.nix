{ ... }: {
  systemd.services.mullvad-daemon = {
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
