{ pkgs, ... }:
{
  # DNS-based website blocking with schedules
  services.blocky = {
    enable = true;
    settings = {
      ports.dns = 53;

      upstreams.groups.default = [
        "https://dns.cloudflare.com/dns-query"
        "https://dns.google/dns-query"
      ];

      # Define block groups — fill in domains per category
      blocking = {
        denylists = {
          social = [
            # "reddit.com"
            # "twitter.com"
            # "instagram.com"
          ];
          video = [
            # "youtube.com"
            # "twitch.tv"
            # "tiktok.com"
          ];
          news = [
            # "news.ycombinator.com"
            # "bbc.co.uk"
          ];
        };

        clientGroupsBlock.default = [
          "social"
          "video"
          "news"
        ];

        blockType = "zeroIp";
      };

      # Schedule overrides — unblock groups during allowed windows
      # See: https://0xerr0r.github.io/blocky/latest/configuration/#schedule
      #
      # blocking.schedule = {
      #   groups.social = {
      #     weekdays = "8-18";
      #   };
      # };
    };
  };

  # Point system DNS to blocky
  networking.nameservers = [ "127.0.0.1" ];
  services.resolved.enable = false;

  # App blocking — kill running apps and hide .desktop files on schedule
  # Apps can still be launched via CLI, but vanish from the app launcher
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
