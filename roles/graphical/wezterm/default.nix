{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.my.roles.graphical;
in {
  programs.wezterm = {
    enable = cfg.enable && cfg.terminal == "wezterm";
    package = lib.my.gl.nixGlWrap {
      inherit config;
      inherit pkgs;
      pkg = pkgs.wezterm;
    };
    extraConfig = builtins.readFile ./config.lua;
  };

  xdg.configFile."wezterm/nix.lua" = lib.mkIf cfg.enable {
    text = ''
      return {
        font = {
          name = "${cfg.font.name}",
          size = ${toString cfg.font.size},
        }
      }
    '';
  };
}
