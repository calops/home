{
  config,
  lib,
  pkgs,
}: let
  cfg = config.my.roles.terminal;
in {
  options = {
    my.roles.terminal.enable = mkOptionEnable {
      default = true;
      description = "Enable terminal utilities";
    };
  };
  config = lib.mkIf cfg.enable {};
}
