{ pkgs, ... }:
{
  # Udev rules
  services.udev.extraRules = ''
    # Controller rules for Steam
    SUBSYSTEM=="usb", ATTRS{idVendor}=="28de", MODE="0666"
    KERNEL=="uinput", MODE="0660", GROUP="pgriffais", OPTIONS+="static_node=uinput"
    KERNEL=="hidraw*", ATTRS{idVendor}=="28de", MODE="0666"
    KERNEL=="hidraw*", KERNELS=="*28DE:*", MODE="0666"
  '';

  # Steam
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
  environment.systemPackages = with pkgs; [
    gamescope-wsi
    gamescope
    mangohud
  ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    protontricks.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  # Game Streaming Host
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
    applications.apps = [
      {
        name = "Steam Deck Mode";
        prep-cmd = [
          {
            do = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.DP-1.mode.1280x800@90";
            undo = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.DP-1.mode.3840x2160@239.99";
          }
        ];
        exclude-global-prep-cmd = "false";
        auto-detach = "true";
      }
    ];
  };
}
