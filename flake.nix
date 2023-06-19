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
    nixd.url = "github:nix-community/nixd";
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
      inputs.nixd.overlays.default
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

    mkHomeConfiguration = configurationName: machine:
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
            ./colorschemes
            ./machines/${machine}.nix
            {home.stateVersion = "23.05";}
          ];
        extraSpecialArgs = {
          inherit inputs;
          inherit configurationName;
          lib = mkLib pkgs;
        };
      };
    mkHomeConfigurations = configs: builtins.mapAttrs (name: machine: mkHomeConfiguration name machine) configs;
  in {
    homeConfigurations = mkHomeConfigurations {
      "calops@tocardstation" = "tocardstation";
      "user@stockly-409" = "stockly-laptop";
      "rlabeyrie@charybdis" = "stockly-charybdis";
    };
  };
}
