{...}: {
  home = {
    username = "calops";
    homeDirectory = "/home/calops";
  };

  my.roles.terminal.enable = true;
  my.roles.graphical = {
    enable = true;
    nvidia.enable = true;
    terminal = "kitty";
  };
}
