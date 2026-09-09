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
  
  # Default editor
  programs.neovim.defaultEditor = true;
  
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
  virtualisation.docker.enable = true;

  # bash
  programs.bash.enable = true;

  # zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.promptInit =
    "source ${pkgs.zsh-powerlevel10k}" + "/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";

  # Increase sudo time
  security.sudo.extraConfig = ''
    	Defaults timestamp_timeout=30
    	Defaults timestamp_type=global
  '';
  
  # Nix Link Loader for dynamically linked executables
  programs.nix-ld.enable = true;

  # Binary Cache Subsituters
  nix = {
    settings = {
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };  

}
