{ config, ... }:
{
  sops.secrets = {
    "pc/wireguard-key" = {
      group = config.users.users.systemd-network.group;
      sopsFile = ./../../../secrets/hosts.yaml;
      reloadUnits = [ "systemd-networkd.service" ];
      mode = "0640";
    };
  };

  networking.wireguard = {
    enable = true;

    interfaces = {
      wg0 = {
        privateKeyFile = config.sops.secrets."pc/wireguard-key".path;

        ips = [ "10.0.0.1/24" ];
        listenPort = 51820;
        mtu = 1420;

        # IP forwarding for peers to reach Sunshine
        postSetup = ''
          ${config.networking.firewall.package}/bin/iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o enp12s0 -j MASQUERADE
          ${config.networking.firewall.package}/bin/iptables -A FORWARD -i wg0 -j ACCEPT
          ${config.networking.firewall.package}/bin/iptables -A FORWARD -o wg0 -j ACCEPT
        '';
        postShutdown = ''
          ${config.networking.firewall.package}/bin/iptables -t nat -D POSTROUTING -s 10.0.0.0/24 -o enp12s0 -j MASQUERADE
          ${config.networking.firewall.package}/bin/iptables -D FORWARD -i wg0 -j ACCEPT
          ${config.networking.firewall.package}/bin/iptables -D FORWARD -o wg0 -j ACCEPT
        '';

        peers = [
          {
            # Steam Deck
            # Replace with the actual public key from the Deck after running:
            #   wg genkey | tee privatekey | wg pubkey > publickey
            publicKey = "REPLACE_WITH_STEAMDECK_PUBLIC_KEY";
            allowedIPs = [ "10.0.0.2/32" ];
          }
        ];
      };
    };
  };

  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
}
