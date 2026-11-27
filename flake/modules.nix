{ inputs, ... }: {
  imports = [
    inputs.flake-parts.flakeModules.modules
    ../modules/nixos/hardware/nvidia.nix
    ../modules/nixos/hardware/corsair.nix
  ];
}
