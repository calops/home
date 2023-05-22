{...}: {
  home = {
    username = "user";
    homeDirectory = "/home/user";
  };

  my.roles.terminal.enable = true;
  my.roles.graphical = {
    enable = true;
    terminal = "wezterm";
  };
}
