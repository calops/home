{config, ...}: {
  imports = [
    ./terminal
    ./graphical
  ];

  programs.home-manager.enable = true;

  xdg.configFile."nixpkgs/config.nix".text = ''
    {
      allowUnfree = true;
    }
  '';

  home.sessionVariables = {
    EDITOR = "nvim";
    STOCKLY_MAIN = "${config.home.homeDirectory}/stockly/Main";
  };

  home.file.scripts = {
    source = ../scripts;
    recursive = true;
  };

  programs.gpg = {
    enable = true;
  };
}
