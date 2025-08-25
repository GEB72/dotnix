{ config, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  # Storage Optimisation
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-generations +10";
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # State Version
  system.stateVersion = "24.11";
}
