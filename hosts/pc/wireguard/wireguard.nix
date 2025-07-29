{ config, ... }: {
	# Load private key
	sops.secrets = {
		"pc/wireguard-key" = {
			group = config.users.users.systemd-network.group;
			sopsFile = ./../../../secrets/hosts.yaml;
      reloadUnits = [ "systemd-networkd.service" ];
      mode = "0640";
		};
	};

	# Wireguard
	networking.wireguard = {
		# Enable the service
		enable = true;

		# Set wg0 client interface 
		interfaces = {
			wg0 = {
				privateKeyFile = config.sops.secrets."pc/wireguard-key".path; 

				ips = [ "10.0.0.2/24" ];
				listenPort = 51820;
				mtu = 1420; 

				peers = [{
						publicKey = "UQ3113obKf6EZuKccgY5sIfD1HplVV0fOS8m5wT/OVQ=";
						allowedIPs = [ "0.0.0.0/0" "::/0" ];
						endpoint = "[2a00:23cc:b717:8e01:e1e3:674c:700c:26ee]:51820";
						persistentKeepalive = 25;
				}]; 
			};
		};
	};
}
