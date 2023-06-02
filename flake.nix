{
  description = "Home-manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hy3 = {
      url = "github:outfoxxed/hy3";
      inputs.hyprland.follows = "hyprland";
    };

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

    extraModules = [
      inputs.hyprland.homeManagerModules.default
    ];

    mkLib = pkgs:
      pkgs.lib.extend
      (self: super:
        {
          my = import ./lib {
            inherit pkgs;
            lib = self;
          };
        }
        // home-manager.lib);

    mkHomeConfiguration = machine:
      home-manager.lib.homeManagerConfiguration rec {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
          overlays = overlays;
        };
        modules =
          extraModules
          ++ [
            ./roles
            ./machines/${machine}.nix
            {home.stateVersion = "23.05";}
          ];
        extraSpecialArgs = {
          inherit inputs;
          lib = mkLib pkgs;
        };
      };
  in {
    homeConfigurations = {
      "calops@tocardstation" = mkHomeConfiguration "tocardstation";
      "user@stockly-409" = mkHomeConfiguration "stockly-laptop";
      "rlabeyrie@charybdis" = mkHomeConfiguration "stockly-charybdis";
    };
  };
}
