{ pkgs, ... }:
{
  environment.variables.EDITOR = "nvim --clean";

  environment.systemPackages = with pkgs; [
    # Utils
    pavucontrol
    ripgrep
    bottom
    unzip
    tree
    wget
    stow
    sops
    lact
    age
    git
    jq

    # Audio/Bluetooth
    easyeffects
    bluez

    # Language
    rustc
    gcc
    go

    # Server
    wireguard-tools
    iptables

    # Terminal
    lazygit
    kitty
    zsh

    # LSP
    lua-language-server
    gopls
    nil

		# Formatters
		nixfmt
		nixfmt-tree

    # Appearance
    zsh-powerlevel10k
    fastfetch
    wlsunset
    nwg-look

    # Apps
    obsidian
    postman
    firefox
    neovim
    heroic
    rofi
    yazi
    mpv

    # Desktop
    wl-clipboard
    gamescope
    hyprpaper
    spotify
    waybar
    clipse
    slurp
    grim
  ];
}
