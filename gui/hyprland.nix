{ hyprland
, withGui
, pkgs
, lib
, config
, ...
}: {
#  imports = [
#    inputs.hyprland.homeManagerModules.default
#  ];

  programs = {
    fish.loginShellInit = ''
      if test (tty) = "/dev/tty1"
        exec Hyprland &> /dev/null
      end
    '';
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = hyprland.packages.${pkgs.system}.default;
    extraConfig = "";
  };
}
