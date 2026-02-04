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

  # Plasma 6
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  environment.systemPackages = with pkgs; [
    kdePackages.filelight
  ];

  # Virtualisation
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "jakub" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # bash
  programs.bash.enable = true;

  # zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.promptInit =
    "source ${pkgs.zsh-powerlevel10k}" + "/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";

  # Increase sudo time
  security.sudo.extraConfig = ''
    	Defaults timestamp_timeout=300
    	Defaults timestamp_type=global
  '';
}
