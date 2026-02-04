{ config, pkgs, ... }:
{
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

			"actions/build-toucan-token" = {
        sopsFile = ./../../secrets/secret.yaml;
			};
    };
  };

  # Create user
  users.users.jakub = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets."jakub/password".path;
    description = "Jakub Mikulski";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
    ];

    openssh.authorizedKeys.keys = [
      (builtins.readFile ./public-keys/id_me.pub)
    ];

    packages = with pkgs; [ ];
  };

  # Configure home-manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.jakub = ./home/home.nix;
  };
}
