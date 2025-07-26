{ config, ... }: {
	imports = [
		./hardware-configuration.nix
	];

  # Bootloader
	boot.loader = {
		systemd-boot.enable = true;
		efi.canTouchEfiVariables = true;	
	};

	# Storage Optimisation
	nix.optimise.automatic = true;
	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-generations +5";
	};

  # Graphics Card
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics = {
    enable = true;
  };
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

	# State Version
  system.stateVersion = "24.11";
}
