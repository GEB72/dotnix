{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		sops-nix.url = "github:Mic92/sops-nix";
		sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, sops-nix }: {

		# Set Host Configs
		nixosConfigurations = {
			pc = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					sops-nix.nixosModules.sops
					./users/jakub/user.nix
					./modules/modules.nix
					./hosts/pc/pc.nix
				];
			};
		};
  };
}
