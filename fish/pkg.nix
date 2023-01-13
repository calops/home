withGUI: {
    programs.fish = {
        enable = withGUI;
        interactiveShellInit = (builtins.readFile "./init.interactive.fish");
    };
}
