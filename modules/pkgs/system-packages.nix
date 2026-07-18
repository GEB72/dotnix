{ pkgs, ... }:
{
  environment.variables.EDITOR = "nvim --clean";

  environment.systemPackages = with pkgs; [
    # Utils
    moreutils
    ripgrep
    expect
    p7zip
    unrar
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

    # Production/VST
    #bitwig-studio
    #vital

    # Audio/Bluetooth
    pavucontrol
    easyeffects
    bluez
    mixxx

    # Language/Dev
    javaPackages.compiler.openjdk25
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
    firefox
    neovim
    yazi
    mpv

    # Desktop
    wl-clipboard
    clipse
    slurp
    grim
  ];
}
