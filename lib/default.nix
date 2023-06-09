{
  lib,
  pkgs,
  ...
}: {
  nixGlWrap = {
    config,
    pkg,
  }: let
    nixGlBin =
      if config.my.roles.graphical.nvidia.enable
      then lib.getExe pkgs.nixgl.auto.nixGLNvidia
      else lib.getExe pkgs.nixgl.nixGLIntel;
  in
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
    '';
  fonts = {
    iosevka-comfy = {
      name = "Iosevka Comfy";
      pkg = pkgs.iosevka-comfy.comfy;
    };
    luculent = {
      name = "Luculent";
      pkg = pkgs.luculent;
    };
  };
}
