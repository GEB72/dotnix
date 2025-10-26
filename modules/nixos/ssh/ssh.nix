{ ... }:
{
  # SSH
  services.openssh = {
    enable = true;
    startWhenNeeded = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "jakub" ];
      UseDns = true;
      X11Forwarding = false;
    };
  };
}
