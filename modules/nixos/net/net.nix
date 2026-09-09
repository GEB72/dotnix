{ pkgs, ... }:
{
  # Enable networking
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [ networkmanager-openvpn ];
  };
  networking.hostName = "nixos";

  # NAT
  networking.nat.enable = true;
  networking.nat.externalInterface = "enp12s0";
  networking.nat.internalInterfaces = [ "wg0" ];
  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
  };
}
