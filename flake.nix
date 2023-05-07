{
  description = "Home-manager configuration";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
  };

  outputs = {
    self,
    home-manager,
    nixpkgs,
    utils,
    alejandra,
    nur,
  }: let
    pkgsForSystem = system:
      import nixpkgs {
        inherit system;
      };

    mkHomeConfiguration = args:
      home-manager.lib.homeManagerConfiguration (
        {
          pkgs = pkgsForSystem args.system or "x86_64-linux";
          modules = [
            ./home.nix
            {
              home = {
                username = "calops";
                homeDirectory = "/home/calops";
                stateVersion = "23.05";
              } // args.home or {};
            }
          ];
          extraSpecialArgs = args.extraSpecialArgs or {};
        }
      );
  in {
    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
    homeConfigurations = {
      "calops@tocardstation" = mkHomeConfiguration {
        extraSpecialArgs = {
          withGui = true;
          isLaptop = false;
        };
      };
    };
  };
}
