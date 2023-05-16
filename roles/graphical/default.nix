{
  config,
  lib,
  pkgs,
}: let
  cfg = config.my.roles.graphical;
in {
  options = {
    my.roles.graphical.enable = mkOptionEnable {
      default = false;
      description = "Enable graphical environment";
    };
    my.roles.graphical.glHack.enable = mkOptionEnable {
      default = false;
      description = "Enable GL wrapper for troublesome programs";
    };
  };
  config = lib.mkIf cfg.enable {
    imports = [
      ./kitty.nix
    ];
  };
}
