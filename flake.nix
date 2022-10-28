{
  description = "Dotfiles on NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: 
    let
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    rec {
      legacyPackages = forAllSystems (system: 
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      ); 
    
    nixosConfigurations = {
      balvenie = nixpkgs.lib.nixosSystem {
        pkgs = legacyPackages."x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ ./nixos/configuration.nix ];
      };
    };

    homeConfigurations = {
      "dave@balvenie" = home-manager.lib.homeManagerConfiguration {
        pkgs = legacyPackages."x86_64-linux";
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home-manager/home.nix ];
      };
    };
  };
}
