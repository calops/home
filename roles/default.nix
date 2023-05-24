{config, ...}: {
  imports = [
    ./terminal
    ./graphical
    ./gaming
  ];

  programs.home-manager.enable = true;

  xdg.configFile."nixpkgs/config.nix".text = ''
    {
      allowUnfree = true;
    }
  '';

  home.sessionVariables = {
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
