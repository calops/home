{
  description = "Home-manager configuration";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    home-manager,
    nixpkgs,
    utils,
    alejandra,
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
                username = args.username or "calops";
                homeDirectory = args.homeDirectory or "/home/calops";
                stateVersion = "23.05";
              };
            }
          ];
          extraSpecialArgs = args.extraSpecialArgs or {};
        }
      );
  in {
    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
    homeConfigurations = {
      calops = mkHomeConfiguration {
        extraSpecialArgs = {
          withGui = true;
          isLaptop = false;
        };
      };
    };
  };
}
