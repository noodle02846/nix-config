{ ... }: {
  systemd.services.acpid = {
    serviceConfig = {
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
      # PrivateDevices = true;
      PrivateIPC = true;
      PrivatePIDs = true;
      PrivateTmp = true;
      PrivateUsers = true;

      RestrictSUIDSGID = true;
      RestrictAddressFamilies = [ ];
      RestrictRealtime = true;
      RestrictNamespaces = true;

      RemoveIPC = true;

      SocketBindDeny = "any";
      DynamicUser = false;
      LockPersonality = true;
      NoNewPrivileges = true;
      CapabilityBoundingSet = "";
      SystemCallArchitectures = "native";
      MemoryDenyWriteExecute = true;
    };
  };
}
