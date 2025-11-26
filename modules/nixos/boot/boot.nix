{ pkgs, ... }:
{
  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Disable SMT
  security.allowSimultaneousMultithreading = false;
}
