{ pkgs, ... }: {
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
		age
    git
		jq

    # Bluetooth
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
    rofi
    yazi
		mpv

		# Desktop
    wl-clipboard
		gamescope
		hyprpaper
		waybar
    clipse
		slurp
		grim
	];
}
