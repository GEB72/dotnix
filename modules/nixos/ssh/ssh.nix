{ ... }:
{
  # SSH
  services.openssh = {
    enable = true;

    ports = [ 22 ];
    listenAddresses = [
      {
        addr = "10.0.0.2";
      }
    ];

    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "jakub" ];
      UseDns = true;
      X11Forwarding = false;
    };
  };
}
