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
    applications = {
      "env" = {
        PATH = "$(PATH):$(HOME)/.local/bin";
      };
      apps = [
        {
          name = "Desktop Monitor";
          prep-cmd = [
            {
              do = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.DP-1.mode.2560x1600@240";
              undo = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.DP-1.mode.3840x2160@240";
            }
          ];
          exclude-global-prep-cmd = "false";
          auto-detach = "true";
        }
        {
          name = "Dummy DP-HDMI";
          prep-cmd = [
            {
              do = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.DP-1.disable output.DP-2.enable";
              undo = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.DP-1.enable output.DP-2.disable";
            }
          ];
          exclude-global-prep-cmd = "false";
          auto-detach = "true";
        }
      ];
    };
  };

}
