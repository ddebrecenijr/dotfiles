{
  description = "Dotfiles on NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: 
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };
    
    lib = nixpkgs.lib;

  in {
   homeManagerConfigurations = {
     dave = home-manager.lib.homeManagerConfiguration {
       inherit system pkgs;
       stateVersion = "22.05";
       username = "dave";
       homeDirectory = "/home/dave";
       configuration = {
         imports = [
           ./users/dave/home.nix
         ];
       };
     };
   };

    nixosConfigurations = {
      balvenie = lib.nixosSystem {
        inherit system;
 
        modules = [
         ./system/configuration.nix
        ];
      };
    };
  };
}
