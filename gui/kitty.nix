{
  lib,
  withGui,
  withGLHack,
  nixGLWrap,
  pkgs,
  ...
}: {
  programs.kitty = {
    enable = withGui;
    package = nixGLWrap pkgs.kitty;
    settings = {
      undercurl_style = "thick-sparse";
      font_size = 10;
      font_family = "Iosevka Comfy";
      bold_font = "Iosevka Comfy bold";
      italic_font = "Iosevka Comfy Italic";
      bold_italic_font = "Iosevka Comfy Bold Italic";

      foreground = "#CDD6F4";
      background = "#1E1E2E";
      selection_foreground = "#1E1E2E";
      selection_background = "#F5E0DC";
      cursor = "#F5E0DC";
      cursor_text_color = "#1E1E2E";
      url_color = "#F5E0DC";
      active_border_color = "#B4BEFE";
      inactive_border_color = "#6C7086";
      bell_border_color = "#F9E2AF";
      wayland_titlebar_color = "system";
      active_tab_foreground = "#11111B";
      active_tab_background = "#CBA6F7";
      inactive_tab_foreground = "#CDD6F4";
      inactive_tab_background = "#181825";
      tab_bar_background = "#11111B";

      mark1_foreground = "#1E1E2E";
      mark1_background = "#B4BEFE";
      mark2_foreground = "#1E1E2E";
      mark2_background = "#CBA6F7";
      mark3_foreground = "#1E1E2E";
      mark3_background = "#74C7EC";

      color0 = "#45475A";
      color8 = "#585B70";
      color1 = "#F38BA8";
      color9 = "#F38BA8";
      color2 = "#A6E3A1";
      color10 = "#A6E3A1";
      color3 = "#F9E2AF";
      color11 = "#F9E2AF";
      color4 = "#89B4FA";
      color12 = "#89B4FA";
      color5 = "#F5C2E7";
      color13 = "#F5C2E7";
      color6 = "#94E2D5";
      color14 = "#94E2D5";
      color7 = "#BAC2DE";
      color15 = "#A6ADC8";
    };
    extraConfig = ''
      modify_font underline_position +2
      modify_font underline_thickness 2px
    '';
    keybindings = {
      "ctrl+tab" = "no_op";
      "ctrl+shift+tab" = "no_op";
    };
  };
}
