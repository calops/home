{
  withGui,
  nixGLWrap,
  pkgs,
  ...
}: {
  programs.wezterm = {
    enable = withGui;
    package = nixGLWrap pkgs.wezterm;
    extraConfig = ''
      local wezterm = require("wezterm")
      local act = wezterm.action

      return {
      	term = "wezterm",
      	font = wezterm.font("Iosevka Comfy"),
      	font_size = 10,
      	underline_thickness = 2,
      	underline_position = -2,
      	enable_tab_bar = false,
      	color_scheme = "Catppuccin Mocha",
      	allow_square_glyphs_to_overflow_width = "Always",
      	animation_fps = 30,
      	cursor_blink_rate = 500,
      	default_cursor_style = "BlinkingBlock",
      	window_padding = {
      		left = 0,
      		bottom = 0,
      		top = 0,
      		right = 0,
      	},
      	visual_bell = {
      		fade_in_function = "Ease",
      		fade_in_duration_ms = 150,
      		fade_out_function = "Ease",
      		fade_out_duration_ms = 150,
      	},
      	keys = {
      		{
      			key = "Tab",
      			mods = "CTRL",
      			action = act.SendKey { key = "Tab", mods = "CTRL" },
      		},
      		{
      			key = "Tab",
      			mods = "CTRL|SHIFT",
      			action = act.SendKey { key = "Tab", mods = "CTRL|SHIFT" },
      		},
      	},
      	unix_domains = {
      		{
      			name = "charybdis-hack",
      			socket_path = "~/charyb.socket",
      			proxy_command = { "ssh", "-T", "-A", "charybdis", "~/.local/bin/wezterm", "cli", "proxy" },
      			local_echo_threshold_ms = 50000,
      		},
      	},
      	ssh_domains = {
      		{
      			name = "charybdis",
      			remote_address = "charybdis",
      			remote_wezterm_path = "~/.local/bin/wezterm",
      		},
      	},
      }
    '';
  };
}
