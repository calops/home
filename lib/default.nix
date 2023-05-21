{lib, ...}: let
  include = l: import l {inherit lib;};
in {
  gl = include ./gl.nix;
}
