{ ... }:
{
  services.navidrome = {
    enable = true;
    openFirewall = false;
    settings = {
      MusicFolder = "/home/jakub/Music";
      Address = "0.0.0.0";
      Port = 4533;
    };
  };
}
