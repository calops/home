{...}: {
  home = {
    username = "user";
    homeDirectory = "/home/user";
  };

  my.roles.terminal = {
    enable = true;
    neovim.full = true;
  };
  my.roles.graphical = {
    enable = true;
    terminal = "wezterm";
  };
}
