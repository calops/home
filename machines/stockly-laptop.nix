{...}: {
  home = {
    username = "user";
    homeDirectory = "/home/user";
  };

  my.roles = {
    terminal = {
      enable = true;
      dev = true;
    };
    graphical.enable = true;
  };
}
