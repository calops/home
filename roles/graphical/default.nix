{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.roles.graphical;
  my.types = with lib; {
    font = types.submodule {
      options = {
        name = mkOption {
          type = types.str;
          default = lib.my.fonts.iosevka-comfy.name;
          description = "Font name";
        };
        package = mkOption {
          type = types.package;
          description = "Font package";
        };
      };
    };
    monitor = types.submodule {
      options = {
        id = mkOption {
          type = types.str;
          default = "eDP-1";
          description = "Monitor name";
        };
        position = mkOption {
          type = types.enum ["left" "right" "above" "below" "center"];
          default = "center";
          description = "Monitor position";
        };
      };
    };
  };
in
  with lib; {
    options = {
      my.roles.graphical = {
        enable = mkEnableOption "Graphical environment";
        nvidia.enable = mkEnableOption "Nvidia tweaks";
        fonts = {
          monospace = mkOption {
            type = my.types.font;
            default = lib.my.fonts.iosevka-comfy;
            description = "Monospace font";
          };
          serif = mkOption {
            type = my.types.font;
            default = lib.my.fonts.noto-serif;
            description = "Serif font";
          };
          sansSerif = mkOption {
            type = my.types.font;
            default = lib.my.fonts.noto-sans;
            description = "Sans-serif font";
          };
          emoji = mkOption {
            type = my.types.font;
            default = lib.my.fonts.noto-emoji;
            description = "Emoji font";
          };
          hinting = mkOption {
            type = types.enum ["Normal" "Mono" "HorizontalLcd"];
            default = "Normal";
            description = "Font hinting strategy";
          };
          sizes = {
            terminal = mkOption {
              type = types.int;
              default = 10;
              description = "Terminal font size";
            };
          };
        };
        installAllFonts = mkEnableOption "Install all fonts";
        terminal = mkOption {
          type = types.enum ["kitty" "wezterm"];
          default = "wezterm";
          description = "Terminal emulator";
        };
        monitors = {
          primary = mkOption {
            type = my.types.monitor;
            default = {
              id = "eDP-1";
              position = "center";
            };
            description = "Primary monitor";
          };
          secondary = mkOption {
            type = my.types.monitor;
            default = null;
            description = "Secondary monitor";
          };
        };
      };
    };
    imports = [
      ./element.nix
      ./wezterm
      ./kitty.nix
      ./ulauncher
      ./gtk.nix
    ];
    config = mkIf cfg.enable {
      fonts.fontconfig.enable = true;
      stylix = {
        image = pkgs.fetchurl {
          url = "https://user-images.githubusercontent.com/4097716/247954752-8c7f3db1-e6a3-4f77-9cc4-262b3d929c36.png";
          sha256 = "sha256-O2AIOKMIgNwZ1/wEZyoVWiby6+FLrNWn9kiSw9rsOAI=";
        };
        fonts = {
          sizes.terminal = cfg.fonts.sizes.terminal;
          serif = cfg.fonts.serif;
          sansSerif = cfg.fonts.sansSerif;
          monospace = cfg.fonts.monospace;
          emoji = cfg.fonts.emoji;
        };
      };
      programs.mpv.enable = true;
      home.pointerCursor = {
        name = "Catppuccin-Mocha-Peach-Cursors";
        size = 32;
        package = pkgs.catppuccin-cursors.mochaPeach;
        gtk.enable = true;
      };
      home.packages =
        if cfg.installAllFonts
        then lib.attrsets.mapAttrsToList (name: font: font.pkg) lib.my.fonts
        else [cfg.fonts.monospace.package];
    };
  }
