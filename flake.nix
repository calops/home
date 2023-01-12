{
    description = "Home-manager configuration";

    inputs = {
        utils.url = "github:numtide/flake-utils";
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, home-manager, nixpkgs, utils }:
        let
            localOverlay = prev: final: {
                polybar-pipewire = final.callPackage ./nix/polybar.nix { };
                nixpkgs-review-fixed = prev.nixpkgs-review.overrideAttrs (oldAttrs: {
                    src = prev.fetchFromGitHub {
                    owner = "Mic92";
                    repo = "nixpkgs-review";
                    rev = "5fbbb0dbaeda257427659f9168daa39c2f5e9b75";
                    sha256 = "sha256-jj12GlDN/hYdwDqeOqwX97lOlvNCmCWaQjRB3+4+w7M=";
                    };
                });
            };

            pkgsForSystem = system: import nixpkgs {
                overlays = [
                    localOverlay
                ];
                inherit system;
            };

            mkHomeConfiguration = args: home-manager.lib.homeManagerConfiguration (rec {
                system = args.system or "x86_64-linux";
                configuration = import ./home.nix;
                homeDirectory = "/home/calops";
                username = "calops";
                pkgs = pkgsForSystem system;
            } // args);

        in utils.lib.eachSystem [ "x86_64-linux" ] (system: rec {
            legacyPackages = pkgsForSystem system;
        }) // {

            overlay = localOverlay;
            nixosModules.home = import ./home.nix; # attr set or list

            homeConfigurations.tocardland = mkHomeConfiguration {
                extraSpecialArgs = {
                    withGUI = true;
                    isDesktop = true;
                    inherit localOverlay;
                };
            };

            inherit home-manager;
        };
}
