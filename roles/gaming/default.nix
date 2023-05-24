{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.roles.gaming;
in
  with lib; {
    options = {
      my.roles.gaming.enable = mkEnableOption "Enable gaming configuration";
    };
    config = mkIf cfg.enable {
      programs.mangohud = {
        enable = true;
        enableSessionWide = true;
      };
    };
  }
