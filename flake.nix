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
    hyprland,
    ...
  } @ inputs: let
    overlays = [
      #inputs.neovim-nightly-overlay.overlay
      inputs.nixgl.overlay
    ];

    modules = [
      hyprland.homeManagerModules.default
    ];

    mkLib = nixpkgs:
      nixpkgs.lib.extend
      (self: super:
        {
          my = import ./lib {
            lib = self;
          };
        }
        // home-manager.lib);
    lib = mkLib inputs.nixpkgs;

    mkHomeConfiguration = machine:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
          overlays = overlays;
        };
        modules =
          modules
          ++ [
            ./roles
            ./machines/${machine}.nix
            {
              home = {
                stateVersion = "23.05";
              };
            }
          ];
        extraSpecialArgs = {
          inherit inputs;
          inherit lib;
        };
      };
  in {
    homeConfigurations = {
      "calops@tocardstation" = mkHomeConfiguration "tocardland";
      "user@stockly-409" = mkHomeConfiguration "stockly-laptop";
      "rlabeyrie@charybdis" = mkHomeConfiguration "stockly-charybdis";
    };
  };
}
