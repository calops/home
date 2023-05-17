{
  lib,
  pkgs,
  withGui,
  withGLHack,
  ...
} @ args: let
  nixGLWrap = pkg:
    if withGLHack
    then
      pkgs.runCommand "${pkg.name}-nixgl-wrapper" {} ''
        mkdir $out
        ln -s ${pkg}/* $out
        rm $out/bin
        mkdir $out/bin
        for bin in ${pkg}/bin/*; do
         wrapped_bin=$out/bin/$(basename $bin)
         echo "exec ${lib.getExe pkgs.nixgl.nixGLIntel} $bin \$@" > $wrapped_bin
         chmod +x $wrapped_bin
        done
      ''
    else pkg;
in {
  fonts.fontconfig.enable = withGui;

  home.packages =
    lib.optional withGui pkgs.iosevka-comfy.comfy
    ++ lib.optional withGLHack pkgs.nixgl.nixGLIntel;

  imports = [
    (import ./kitty.nix (args // {inherit nixGLWrap;}))
    (import ./wezterm.nix (args // {inherit nixGLWrap;}))
    ./element.nix
    #./hyprland.nix
  ];

  programs.eww = {
    enable = false;
    configDir = ./eww;
  };
}
