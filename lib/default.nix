{
  lib,
  nixpkgs,
  ...
}: {
  nixGlWrap = {
    config,
    pkg,
  }: let
    nixGlBin =
      if config.my.roles.graphical.nvidia.enable
      then "nixGLNvidia-530.41.03"
      else "nixGLIntel";
  in
    nixpkgs.runCommand "${pkg.name}-nixgl-wrapper" {} ''
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
      pkg = nixpkgs.iosevka-comfy;
    };
    luculent = {
      name = "Luculent";
      pkg = nixpkgs.luculent;
    };
  };
}
