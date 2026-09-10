{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    musnix.url = "github:musnix/musnix";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  outputs =
    {
      self,
      nixpkgs,
      sops-nix,
      home-manager,
      musnix,
      nixvim,
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
            { home-manager.sharedModules = [ nixvim.homeManagerModules.nixvim ]; }
            musnix.nixosModules.musnix
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
            { home-manager.sharedModules = [ nixvim.homeManagerModules.nixvim ]; }
            ./users/jakub/user.nix
            ./modules/modules.nix
            ./hosts/laptop/laptop.nix
          ];
        };
      };
    };
}
