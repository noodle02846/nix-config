{ ... }: {
  imports = [
    ./ntpd.nix
    ./xserver.nix
    ./mullvad.nix
    ./pipewire.nix
  ];
}
