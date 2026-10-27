{ pkgs, lib, ... }:
let
  mkBlocklist = name: domains:
    toString (pkgs.writeText "blocklist-${name}" (lib.concatStringsSep "\n" domains));
in
{
  services.blocky = {
    enable = true;
    settings = {
      ports.dns = 53;
      upstreams.groups.default = [
        "https://dns.cloudflare.com/dns-query"
        "https://dns.google/dns-query"
      ];
      blocking = {
        denylists = {
          social = [
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
            (mkBlocklist "social" [
              "reddit.com"
              "instagram.com"
            ])
          ];
          video = [
            # (mkBlocklist "video" [
            #   "youtube.com"
            #   "twitch.tv"
            #   "tiktok.com"
            # ])
          ];
        };

        clientGroupsBlock.default = [
          "social"
          "video"
        ];

        schedules = {
          wind-down = {
            weekdays = [ "mon" "tue" "wed" "thu" "fri" ];
            start = "23:00";
            end = "02:00";
          };
          sleep = {
            weekdays = [ "mon" "tue" "wed" "thu" "fri" ];
            start = "02:00";
            end = "07:00";
          };
        };
        listSchedules = {
          social = [ "wind-down" "sleep" ];
        };

        blockType = "zeroIp";
      };
    };
  };

  networking.nameservers = [ "127.0.0.1" ];
  services.resolved.enable = false;

  # App blocking — kill running apps and hide .desktop files on schedule
  # Uncomment and adjust the lists and timers below

  # systemd.services.app-blocker = {
  #   description = "Kill and hide distracting apps";
  #   serviceConfig.Type = "oneshot";
  #   script = let
  #     apps = [
  #       "spotify"
  #       # "discord"
  #       # "slack"
  #     ];
  #     kills = builtins.concatStringsSep "\n"
  #       (map (a: "${pkgs.procps}/bin/pkill -f ${a} || true") apps);
  #     hides = builtins.concatStringsSep "\n"
  #       (map (a: "for f in /run/current-system/sw/share/applications/*${a}*; do [ -e \"$f\" ] && ln -sf /dev/null /home/jakub/.local/share/applications/$(basename \"$f\"); done") apps);
  #   in ''
  #     ${kills}
  #     mkdir -p /home/jakub/.local/share/applications
  #     ${hides}
  #   '';
  # };
  #
  # systemd.services.app-unblocker = {
  #   description = "Restore hidden app launchers";
  #   serviceConfig.Type = "oneshot";
  #   script = let
  #     apps = [
  #       "spotify"
  #       # "discord"
  #       # "slack"
  #     ];
  #     restores = builtins.concatStringsSep "\n"
  #       (map (a: "rm -f /home/jakub/.local/share/applications/*${a}*") apps);
  #   in ''
  #     ${restores}
  #   '';
  # };
  #
  # systemd.timers.app-blocker = {
  #   wantedBy = [ "timers.target" ];
  #   timerConfig.OnCalendar = "Mon..Fri 08:00";
  # };
  #
  # systemd.timers.app-unblocker = {
  #   wantedBy = [ "timers.target" ];
  #   timerConfig.OnCalendar = "Mon..Fri 18:00";
  # };
}
