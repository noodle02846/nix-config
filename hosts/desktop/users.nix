{ pkgs, ... }: {
  users = {
    defaultUserShell = pkgs.zsh;

    users.user = {
      linger = true;
      isNormalUser = true;
      useDefaultShell = true;
      extraGroups = [ "wheel" ];
    };
  };
}
