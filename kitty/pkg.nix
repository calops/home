withGUI: {
    programs.kitty = {
        enable = withGUI;
    };
    xdg.configFile."kitty/kitty.conf" = {
        source = ./kitty.conf;
    };
}
