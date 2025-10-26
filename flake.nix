{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      sops-nix,
      home-manager,
    }:
    {

      # Set Host Configs
      nixosConfigurations = {
        pc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
					specialArgs = {
					  self = self;
					};
          modules = [
            sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager
            ./users/jakub/user.nix
            ./modules/modules.nix
            ./hosts/pc/pc.nix
          ];
        };

        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager
            ./users/jakub/user.nix
            ./modules/modules.nix
            ./hosts/laptop/laptop.nix
          ];
        };
      };
    };
}
