{
  description = "Home-manager configuration";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    hyprland.url = "github:hyprwm/Hyprland";
    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
  };

  outputs = {
    self,
    home-manager,
    nixpkgs,
    ...
  } @ inputs: let
    pkgsForSystem = system:
      import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

    mkHomeConfiguration = args:
      home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsForSystem args.system or "x86_64-linux";
        modules = [
          ./home.nix
          {
            home =
              {
                username = "calops";
                homeDirectory = "/home/calops";
                stateVersion = "23.05";
              }
              // args.home or {};
          }
        ];
        extraSpecialArgs =
          {
            inherit inputs;
            withGui = false;
            isLaptop = false;
            monitors = {};
          }
          // args.extraSpecialArgs or {};
      };
  in {
    nixpkgs.config = {
      allowUnfree = true;
    };
    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
    homeConfigurations = {
      "calops@tocardstation" = mkHomeConfiguration {
        extraSpecialArgs = {
          withGui = true;
          monitors = {
            "DP-1" = {
              primary = true;
            };
          };
        };
      };
    };
  };
}
