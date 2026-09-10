{ config, ... }:
{
  networking.wireguard = {
    enable = true;

    interfaces = {
      wg0 = {
        privateKeyFile = config.sops.secrets."pc/wireguard-key".path;

        ips = [ "10.0.0.1/24" ];
        listenPort = 51820;
        mtu = 1420;

        peers = [
          {
            # Steam Deck
            publicKey = "2URgjtEvjnkV/BuFC1Jl6Pe0IIUoOcezmapQpiuNTV0=";
            allowedIPs = [ "10.0.0.2/32" ];
          }
        ];
      };
    };
  };

}
