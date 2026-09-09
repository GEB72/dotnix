{ config, pkgs, ... }:
{
  # Enable networking
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [ networkmanager-openvpn ];
  };
  networking.hostName = "nixos";

  # DuckDNS
  services.duckdns = {
    enable = true;
    domains = [ "jakub-pc" ];
    tokenFile = config.sops.secrets."pc/duckdns-token".path;
  };

  # NAT
  networking.nat.enable = true;
  networking.nat.externalInterface = "enp12s0";
  networking.nat.internalInterfaces = [ "wg0" ];
  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
  };
}
