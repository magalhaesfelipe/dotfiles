-- CONFIG WITH WITHOUT TAB BAR
local wezterm = require("wezterm")
local config = {}

config.default_prog = {
    "C:\\Program Files\\Git\\bin\\bash.exe",
    "--login",
    "-i",
}

-- config.default_cwd = "C:\\Users\\rgm-79N"

-- Window
config.window_background_opacity = 0.9
config.window_decorations = "RESIZE"

config.window_padding = {
	left = 12,
	right = 12,
	top = 10,
	bottom = 10,
}

config.initial_cols = 70
config.initial_rows = 20

-- Tab bar
config.use_fancy_tab_bar = false   -- so colors.tab_bar.* is honored
config.tab_bar_at_bottom = false
config.show_new_tab_button_in_tab_bar = false

-- Smaller tab font
config.window_frame = {
	font_size = 1.0,
}

-- Colors
local bg = "rgba(29, 32, 33, 0.8)" -- #1D2021 at the same opacity as the window

config.colors = {
	background = "#1D2021",
	tab_bar = {
		background = bg,

		active_tab = {
			bg_color = bg,
			fg_color = "#FFFFFF",
		},
		inactive_tab = {
			bg_color = bg,
			fg_color = "#808080",
		},
		inactive_tab_hover = {
			bg_color = "rgba(45, 48, 50, 0.91)",
			fg_color = "#FFFFFF",
		},
		new_tab = {
			bg_color = "rgb(45, 48, 50)",
			fg_color = "#808080",
		},
		new_tab_hover = {
			bg_color = "rgba(45, 48, 50, 0.91)",
			fg_color = "#FFFFFF",
		},
	},
}

config.hide_mouse_cursor_when_typing = false
config.front_end = "WebGpu"

-- Key bindings
config.keys = {
	{
		key = "Space",
		mods = "CTRL",
		action = wezterm.action.SendKey({
			key = "w",
			mods = "CTRL",
		}),
	},
}

return config
