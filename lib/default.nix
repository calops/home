{
  lib,
  nixpkgs,
  ...
}: let
  mkScriptWrapper = {
    pkg,
    suffix,
    text,
  }:
    nixpkgs.runCommand "${pkg.name}-${suffix}" {} ''
      mkdir $out
      ln -s ${pkg}/* $out
      rm $out/bin
      mkdir $out/bin
      for bin in ${pkg}/bin/*; do
        wrapped_bin=$out/bin/$(basename $bin)
        cat >$wrapped_bin <<"EOF"
      ${text}
      EOF
        chmod +x $wrapped_bin
      done
    '';
in {
  nixGlWrap = {
    config,
    pkg,
  }: let
    nixGlBin =
      if config.my.roles.graphical.nvidia.enable
      then "nixGLNvidia-530.41.03"
      else "nixGLIntel";
  in
    mkScriptWrapper {
      inherit pkg;
      suffix = "nixGL";
      text = ''
        exec ${nixGlBin} $bin \$@"
      '';
    };
}
