{ config, ... }:
{
  # RSS Reader
  services.freshrss = {
    enable = true;
    api.enable = true;
    virtualHost = "freshrss.jakub.com";
    baseUrl = "https://freshrss.jakub.com";
    webserver = "nginx";
    defaultUser = "jakub";
    passwordFile = "/etc/secrets/freshrss";
  };

}

