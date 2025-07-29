{ config, pkgs, ... }: {
	# Assign secrets
	sops = {
		secrets = {
			"jakub/password" = {
				sopsFile = ./../../secrets/users.yaml;
				neededForUsers = true;
			};

			"jakub/ssh-key" = {
				sopsFile = ./../../secrets/users.yaml;
				path = "home/jakub/.ssh/id_ed25519";
				owner = config.users.users.jakub.name;
				inherit (config.users.users.jakub) group;
			};

			"twilio/account_sid" = {};
			"twilio/auth_token" = {};

			"cognito/user_pool_id" = {};
			"cognito/client_id" = {};
			"cognito/secret" = {};

			"kms/key_id" = {};
		};
	};

	# Create user
  users.users.jakub = {
    isNormalUser = true;
		hashedPasswordFile = config.sops.secrets."jakub/password".path;
    description = "Jakub Mikulski";
    extraGroups = [ "networkmanager" "wheel" ];

		openssh.authorizedKeys.keys = [
			(builtins.readFile ./public-keys/id_me.pub)
		];

    packages = with pkgs; [];
  };
}
