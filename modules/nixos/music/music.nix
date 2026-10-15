{ ... }:
{
  systemd.tmpfiles.rules = [
    "L+ /srv/music - - - - /home/jakub/Music"
  ];

  services.navidrome = {
    enable = true;
    openFirewall = false;
    settings = {
      MusicFolder = "/srv/music";
      Address = "0.0.0.0";
      Port = 4533;
    };
  };
}
