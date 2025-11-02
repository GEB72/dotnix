{ pkgs, ... }:
{
  environment.variables.EDITOR = "nvim --clean";

  environment.systemPackages = with pkgs; [
    # Utils
    moreutils
    ripgrep
    expect
    evtest
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
    pavucontrol
    easyeffects
    ardour
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
    wlsunset
    nwg-look

    # Apps
    atlauncher
    obsidian
    postman
    firefox
    neovim
    heroic
    rofi
    yazi
    vial
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
