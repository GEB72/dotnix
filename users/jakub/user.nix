{ config, pkgs, ... }: {
  users.users.jakub = {
    isNormalUser = true;
    description = "Jakub Mikulski";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
}
