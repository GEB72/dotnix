{ config, ... }:
{
  # RSS Reader
  services.freshrss = {
    enable = true;
    api.enable = true;
    webserver = "nginx";
    virtualHost = "jakub.rss.com";
    baseUrl = "http://jakub.rss.com";
    defaultUser = "jakub";
    passwordFile = config.sops.secrets."jakub/rss-password".path;
  };

  # RSS Database
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "freshrss" ];
    ensureUsers = [
      {
        name = "freshrss";
        ensureDBOwnership = true;
      }
    ];
  };

  # DNS
  networking.hosts = {
    "127.0.0.1" = [ "jakub.rss.com" ];
    "::1" = [ "jakub.rss.com" ];
  };

}

