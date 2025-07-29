{ config, pkgs, ... }: {
	# Assign secrets
	sops = {
		secrets = {
			"jakub/password" = {
				sopsFile = ./../../secrets/users.yaml;
				neededForUsers = true;
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
    packages = with pkgs; [];
  };
}
