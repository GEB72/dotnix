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

      "jakub/rss-password" = {
        sopsFile = ./../../secrets/users.yaml;
        path = "/etc/secrets/freshrss";
        owner = config.services.freshrss.user;
        group = "freshrss";
      };

      "pc/wireguard-key" = {
        sopsFile = ./../../secrets/hosts.yaml;
        group = config.users.users.systemd-network.group;
        reloadUnits = [ "systemd-networkd.service" ];
        mode = "0640";
      };

      "pc/duckdns-token" = {
        sopsFile = ./../../secrets/hosts.yaml;
        mode = "0400";
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
      "docker"
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
