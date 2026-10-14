{ ... }: {
  systemd.services.ckb-next = {
    serviceConfig =
      let
        serviceName = "ckb-next";
      in
      {
        ProtectSystem = "strict";
        ProtectProc = "invisible";
        ProtectClock = true;
        ProtectHome = true;
        ProtectKernelLogs = true;
        ProtectKernelModules = true;
        ProtectHostname = true;
        ProtectKernelTunables = true;
        ProtectControlGroup = "strict";

        PrivateMounts = true;
        PrivateIPC = true;
        PrivatePIDs = true;
        PrivateTmp = true;
        PrivateNetwork = true;

        RestrictAddressFamilies = "";
        RestrictRealtime = true;
        RestrictNamespaces = true;

        RemoveIPC = true;

        RuntimeDirectory = "${serviceName}";
        RootDirectory = "/run/${serviceName}";
        StateDirectory = "${serviceName}";
        LogsDirectory = "${serviceName}";
        WorkingDirectory = "/var/lib/${serviceName}";

        BindPaths = [
          "/var/lib/${serviceName}"
          "/dev/input"
        ];
        BindReadOnlyPaths = [ builtins.storeDir ];

        ReadWritePaths = "";
        UMask = "0007";

        DynamicUser = false;
        LockPersonality = true;
        NoNewPrivileges = true;

        CapabilityBoundingSet = "CAP_CHOWN";

        SocketBindDeny = "any";

        SystemCallErrorNumber = "EPERM";
        SystemCallFilter = [ "@system-service" ];
        SystemCallArchitectures = "native";

        MemoryDenyWriteExecute = true;
      };
  };
}
