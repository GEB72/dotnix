{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
		# Set Host Configs
		nixosConfigurations = {
			pc = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					./users/jakub/user.nix
					./modules/modules.nix
					./hosts/pc/pc.nix
				];
			};
		};
  };
}
