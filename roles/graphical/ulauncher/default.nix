{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.my.roles.graphical;
in
  with lib; {
    config = mkIf cfg.enable {
      home.packages = [pkgs.ulauncher];

      xdg.configFile.ulauncher = {
        source = ./config;
        recursive = true;
      };
    };
  }
