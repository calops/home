{...}: {
  home = {
    username = "calops";
    homeDirectory = "/home/calops";
  };

  my.roles = {
    terminal = {
      enable = true;
      dev = true;
    };
    graphical = {
      enable = true;
      nvidia.enable = true;
      terminal = "kitty";
    };
    gaming.enable = true;
  };
}
