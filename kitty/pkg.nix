withGUI: {
    enable = withGUI;
    font = {
        name = "Iosevka";
        size = 10.5;
    };
    keybindings = {
        "ctrl+tab" = "no_op";
        "ctrl+shift+tab" = "no_op";
    };
    extraConfig = (import "kitty.conf");
}
