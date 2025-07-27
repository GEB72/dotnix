{ config, pkgs, ... }: {
	# Create user
  users.users.jakub = {
    isNormalUser = true;
    description = "Jakub Mikulski";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

	# Assign secrets
	sops = {
		secrets = {
			"twilio/account_sid" = {};
			"twilio/auth_token" = {};

			"cognito/user_pool_id" = {};
			"cognito/client_id" = {};
			"cognito/secret" = {};

			"kms/key_id" = {};
		};
	};
}
