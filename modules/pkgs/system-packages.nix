{ pkgs, ... }:
{
  environment.variables.EDITOR = "nvim --clean";

  environment.systemPackages = with pkgs; [
    # Utils
    moreutils
    ripgrep
    expect
    bottom
    p7zip
    tree
    wget
    stow
    sops
    lact
    wine
    age
    git
    jq

    # Production/VST
    bitwig-studio
    vital

    # Audio/Bluetooth
    pavucontrol
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
