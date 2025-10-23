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

  # zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
}
