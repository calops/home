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
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = {
    self,
    home-manager,
    nixpkgs,
    ...
  } @ inputs: let
    overlays = [
      inputs.neovim-nightly-overlay.overlay
    ];
    mkHomeConfiguration = args:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = args.system or "x86_64-linux";
          config.allowUnfree = true;
          overlays = overlays;
        };
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
      "rlabeyrie@charybdis" = mkHomeConfiguration {
        home = {
          username = "rlabeyrie";
          homeDirectory = "/home/rlabeyrie";
        };
        extraSpecialArgs = {
          withGui = false;
        };
      };
    };
  };
}
