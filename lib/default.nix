{lib, ...}: let
  addLib = l: import l {inherit lib;};
in {
  gl = addLib ./gl.nix;
}
