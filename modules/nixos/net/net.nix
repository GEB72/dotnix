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
    extraCommands = ''
      # Only allow SSH through LAN and WireGuard
      iptables -A nixos-fw -p tcp --dport 22 -s 192.168.0.0/16 -j nixos-fw-accept
      iptables -A nixos-fw -p tcp --dport 22 -s 10.0.0.0/24 -j nixos-fw-accept
    '';
  };
}
