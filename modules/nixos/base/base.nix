{ pkgs, ... }:
{
  # Enable Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

	# Allow flatpaks (needed for Steam Link)
	services.flatpak.enable = true;

  # Disable mutable users
  users.mutableUsers = false;

  # Tiling Manager
  programs.hyprland.enable = true;
	
	# Vial udev rules
	services.udev.extraRules = 
	  "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", " +
		"ATTRS{serial}==\"*vial:f64c2b3c*\", MODE=\"0660\", " + 
		"GROUP=\"users\", TAG+=\"uaccess\", TAG+=\"udev-acl\" ";

  # zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.promptInit = "source ${pkgs.zsh-powerlevel10k}" +
	"/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
}
