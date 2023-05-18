{
  lib,
  pkgs,
  withGui,
  withGLHack,
  withNvidia,
  ...
} @ args: let
  nixGlPkg =
    if withNvidia
    then pkgs.nixgl.auto.nixGLNvidia
    else pkgs.nixgl.nixGLIntel;
  nixGlBin =
    if withNvidia
    then "nixGLNvidia-530.41.03"
    else "nixGLIntel";
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
         echo "exec ${nixGlBin} $bin \$@" > $wrapped_bin
         chmod +x $wrapped_bin
        done
      ''
    else pkg;
in {
  fonts.fontconfig.enable = withGui;

  home.packages =
    lib.optional withGui pkgs.iosevka-comfy.comfy
    ++ lib.optional withGLHack nixGlPkg;

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
