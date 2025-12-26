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
  boot.kernelParams = [
    "amdgpu.ppfeaturemask=0xffffffff"
    "drm.edid_firmware=DP-2:edid/custom1.bin"
		"video=DP-2:2560x1600@90"
  ];
  systemd.services.lact = {
    description = "AMDGPU Control Daemon";
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.lact}/bin/lact daemon";
    };
    enable = true;
  };

  # Export Custom EDIDs
  hardware.display.edid = {
    enable = true;
    packages = [
      (pkgs.runCommand "edid-custom" { } ''
        mkdir -p "$out/lib/firmware/edid"
        base64 -d > "$out/lib/firmware/edid/custom1.bin" <<'EOF'
        AP///////wAQrEaiU0kzMB4iAQS1Rih4OwMhr04+tSUNUFSlSwBxT4GAqcDRwAEBAQEBAQEBTdAA
        oPBwPoAwIDUAu4shAAAaAAAA/wAzUTc1WVozCiAgICAgAAAA/ABBVzMyMjVRRgogICAgAAAA/Qww
        8P//6gEKICAgICAgAuwCAyWxUnZhYF9eXT8iISAfExIQBAMCAeMFwwHmBgUBik8C4gDqAAAAAAAA
        AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
        AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPXASeQMAAwFkX+QABH8HswA/gD8ANwRPAAIABABu
        wgAE/wmfAC+AHwCfBVQAAgAEAMqcAQT/CZ8AL4AfAJ8FsgACAAQA1o4DBP8OnwAvgB8AbwgMAQIA
        BABVXgAE/wmfAC+AHwCfBSgAAgAEAAAAAAAAAAAAAAAAAAAAAAAAAKyQ
        EOF
      '')
    ];
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # State Version
  system.stateVersion = "24.11";
}
