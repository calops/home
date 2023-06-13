{lib, ...}: {
  home = {
    username = "calops";
    homeDirectory = "/home/calops";
  };

  my.roles = {
    terminal.enable = true;
    graphical = {
      enable = true;
      nvidia.enable = true;
      terminal = "wezterm";
      monitors.primary.id = "DP-2";
    };
    gaming.enable = true;
  };
}
