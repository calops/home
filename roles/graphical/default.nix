{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.roles.graphical;
in
  with lib; {
    options = {
      my.roles.graphical = {
        enable = mkEnableOption "Graphical environment";
        nvidia.enable = mkEnableOption "Nvidia tweaks";
        font = {
          name = mkOption {
            type = types.str;
            default = lib.my.fonts.iosevka-comfy.name;
            description = "Font name";
          };
          size = mkOption {
            type = types.int;
            default = 10;
            description = "Font size";
          };
          pkg = mkOption {
            type = types.package;
            default = lib.my.fonts.iosevka-comfy.pkg;
            description = "Font package";
          };
        };
        terminal = mkOption {
          type = types.enum ["kitty" "wezterm"];
          default = "wezterm";
          description = "Terminal emulator";
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
        cfg.font.pkg
      ];
    };
  }
