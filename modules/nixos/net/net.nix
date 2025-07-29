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
}
