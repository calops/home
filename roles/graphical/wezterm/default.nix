{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.my.roles.graphical;
in
  with lib; {
    config = mkIf (cfg.enable && cfg.terminal == "wezterm") {
      programs.wezterm = {
        enable = true;
        package = lib.my.gl.nixGlWrap {
          inherit config;
          inherit pkgs;
          pkg = pkgs.wezterm;
        };
        extraConfig = builtins.readFile ./config.lua;
      };

      xdg.configFile."wezterm/nix.lua" = {
        text = ''
          return {
          	font = {
          		name = "${cfg.font.name}",
          		size = ${toString cfg.font.size},
          	},
          }
        '';
      };
    };
  }
