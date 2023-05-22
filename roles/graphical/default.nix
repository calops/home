{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.roles.graphical;
  nixGlPkg =
    if cfg.nvidia.enable
    then pkgs.nixgl.auto.nixGLNvidia
    else pkgs.nixgl.nixGLIntel;
in
  with lib; {
    options = {
      my.roles.graphical = {
        enable = mkEnableOption "Graphical environment";
        nvidia.enable = mkEnableOption "Nvidia tweaks";
        font = {
          name = mkOption {
            type = types.str;
            default = "Iosevka Comfy";
            description = "Font name";
          };
          size = mkOption {
            type = types.int;
            default = 10;
            description = "Font size";
          };
          pkg = mkOption {
            type = types.package;
            default = pkgs.iosevka-comfy.comfy;
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
    ];
    config = mkIf cfg.enable {
      fonts.fontconfig.enable = true;
      home.packages = [
        cfg.font.pkg
        nixGlPkg
      ];
    };
  }
