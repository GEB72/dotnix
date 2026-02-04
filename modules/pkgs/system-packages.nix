{ pkgs, ... }:
{
  environment.variables.EDITOR = "nvim --clean";

  environment.systemPackages = with pkgs; [
    # Utils
    moreutils
    ripgrep
    expect
    p7zip
    tree
    wget
    stow
    sops
    wine
    age
    git
    jq

    # Hardware
    lact
    gparted

    # Production/VST
    bitwig-studio
    vital

    # Audio/Bluetooth
    pavucontrol
    easyeffects
    bluez

    # Language
		python314Packages.west
		python3
    rustc
    gcc
    go

    # Server
    wireguard-tools
    iptables

    # Terminal
    lazygit
    bottom
    kitty

    # LSP
    lua-language-server
    gopls
    nil

    # Formatters
    nixfmt-tree
    nixfmt

    # Appearance
    zsh-powerlevel10k
    oh-my-zsh
    fastfetch
    nwg-look

    # Apps
    qbittorrent
    atlauncher
    obsidian
    spotify
    postman
    firefox
    neovim
    heroic
    yazi
    vial
    mpv

    # Desktop
    wl-clipboard
    waybar
    clipse
    slurp
    grim
  ];
}
