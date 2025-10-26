{ self, ... }:
{
	# Vial udev rules
	services.udev.extraRules = 
	  "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", " +
		"ATTRS{serial}==\"*vial:f64c2b3c*\", MODE=\"0660\", " + 
		"GROUP=\"users\", TAG+=\"uaccess\", TAG+=\"udev-acl\" ";

	# Enable Kanata
  services.kanata = {
	  enable = true;
		keyboards."kb".configFile = "${self}/modules/nixos/keyboard/kanata.kbd";
	};
}
