{...}: {
  home = {
    username = "user";
    homeDirectory = "/home/user";
  };

  my.roles = {
    terminal = {
      enable = true;
      dev = true;
      ssh.hosts = {
        charybdis = {
          hostname = "FIXME";
          user = "rlabeyrie";
          port = 23;
        };
        charybdis-remote = {
          hostname = "charybdis.stockly.tech";
          user = "rlabeyrie";
          port = 23;
        };
      };
    };
    graphical.enable = true;
  };
}
