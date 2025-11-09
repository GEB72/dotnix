{ pkgs, config, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./wireguard/wireguard.nix
  ];

  # Storage Optimisation
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-generations +10";
  };

  # Firmware
  hardware.enableRedistributableFirmware = true;

  # Graphics Card
  services.xserver.videoDrivers = [ "amd" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # OC Tool
  systemd.packages = with pkgs; [ lact ];
  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];
  systemd.services.lact = {
    description = "AMDGPU Control Daemon";
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.lact}/bin/lact daemon";
    };
    enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # State Version
  system.stateVersion = "24.11";
}
