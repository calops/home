{
  lib,
  pkgs,
  withGui,
  ...
}: {
  fonts.fontconfig.enable = withGui;

  home.packages = with pkgs;
    lib.mkIf withGui [
      iosevka-comfy.comfy
    ];

  imports = [
    ./kitty.nix
    ./element.nix
    #./firefox.nix
  ];
}
