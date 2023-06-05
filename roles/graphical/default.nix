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
        pkg = mkOption {
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
        font = {
          family = mkOption {
            type = my.types.font;
            default = lib.my.fonts.iosevka-comfy;
            description = "Font family";
          };
          size = mkOption {
            type = types.int;
            default = 10;
            description = "Font size";
          };
          hinting = mkOption {
            type = types.enum ["Normal" "Mono" "HorizontalLcd"];
            default = "Normal";
            description = "Font hinting strategy";
          };
        };
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
    ];
    config = mkIf cfg.enable {
      fonts.fontconfig.enable = true;
      programs.mpv.enable = true;
      home.packages = [
        cfg.font.family.pkg
      ];
    };
  }
