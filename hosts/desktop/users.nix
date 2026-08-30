{ pkgs, ... }: {
  users = {
    defaultUserShell = pkgs.zsh;

    users = {
      user = {
        linger = true;
        isNormalUser = true;
        useDefaultShell = true;
        extraGroups = [
          "wheel"
          "containers"
        ];
      };

      svc = {
        linger = true;
        isNormalUser = true;
        useDefaultShell = true;

        homeMode = "770";

        uid = 10000;
        group = "containers";
      };
    };

    groups.containers = {
      gid = 10000;
    };
  };
}
