{ inputs, ... }: {
  imports = [
    inputs.flake-parts.flakeModules.modules
    ../modules/nixos/hardware/nvidia.nix
  ];
}
