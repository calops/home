{
  pkgs,
  extraSpecialArgs,
  homeDirectory,
  ...
}: {
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.bash
    pkgs.fd
    pkgs.ripgrep
    pkgs.rm-improved
    pkgs.rustup
    pkgs.xcp
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    #STOCKLY_MAIN = "${homeDirectory}/stockly/Main";
  };

  home.file.scripts = {
    source = ./scripts;
    recursive = true;
  };

  imports = [
    ./btop.nix
    ./git.nix
    ./fish.nix
  ];
}
