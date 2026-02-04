{ config, self, ... }:
{
  services.udev.extraRules =
    # Vial udev rules
    "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", "
    + "ATTRS{serial}==\"*vial:f64c2b3c*\", MODE=\"0660\", "
    + "GROUP=\"users\", TAG+=\"uaccess\", TAG+=\"udev-acl\" \n"
    # Symlink keyboard to /dev/input/ udev rules (path changes on reboot)
    + "SUBSYSTEMS==\"input\",  ATTRS{name}==\"ASUSTeK ROG OMNI RECEIVER Keyboard\", "
    + "SYMLINK += \"keyboard\" ";

  # Enable Kanata
  services.kanata = {
    enable = true;
    keyboards."kb".configFile = "${self}/modules/nixos/keyboard/kanata.kbd";
  };

	# Github Runner for Toucan Compilation
	services.github-runners = {
    runner = {
      enable = true;
      name = "runner";
      tokenFile = config.sops.secrets."actions/build-toucan-token".path;
      url = "https://github.com/GEB72/zmk-keyboard-toucan";
    };
	};

}
