{
  pkgs,
  extraSpecialArgs,
  config,
  lib,
  ...
}: {
  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    STOCKLY_MAIN = "${config.home.homeDirectory}/stockly/Main";
  };

  home.file.scripts = {
    source = ./scripts;
    recursive = true;
  };

  imports = [
    ./cli/pkg.nix
    ./gui/pkg.nix
  ];
}
