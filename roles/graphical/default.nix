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
  include = prg: import prg {inherit config lib pkgs;};
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
    config = mkIf cfg.enable (
      (include ./element.nix)
      // (include ./kitty.nix)
      // (include ./wezterm.nix)
      // {
        fonts.fontconfig.enable = true;
        programs.kitty.enable = cfg.terminal == "kitty";
        programs.wezterm.enable = cfg.terminal == "wezterm";
        home.packages = [
          cfg.font.pkg
          nixGlPkg
        ];
      }
    );
  }
