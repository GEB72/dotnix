{ ... }: {
  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "nixos"; 

  # NAT 
  networking.nat.enable = true;
  networking.nat.externalInterface = "eth0";
  networking.nat.internalInterfaces = [ "wg0" ];
  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
  };

  # SSH
  services.openssh = {
    enable = true;

    ports = [ 22 ];
		listenAddresses = [
	  {
	    addr = "10.0.0.1";
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
