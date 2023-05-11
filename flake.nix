{
  description = "Home-manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixgl.url = "github:guibou/nixGL";
  };

  outputs = {
    self,
    home-manager,
    nixpkgs,
    ...
  } @ inputs: let
    overlays = [
      inputs.neovim-nightly-overlay.overlay
      inputs.nixgl.overlay
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
            home = rec {
              username = args.username or "calops";
              homeDirectory = args.homeDirectory or "/home/${username}";
              stateVersion = "23.05";
            };
          }
        ];
        extraSpecialArgs =
          {
            inherit inputs;
            withGui = false;
            isLaptop = false;
            withGLHack = false;
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
      "user@stockly-409" = mkHomeConfiguration {
        username = "user";
        extraSpecialArgs = {
          withGui = true;
          withGLHack = true;
          isLaptop = true;
        };
      };
      "rlabeyrie@charybdis" = mkHomeConfiguration {
        username = "rlabeyrie";
        extraSpecialArgs.withGui = false;
      };
    };
  };
}
