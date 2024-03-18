-- ------------
-- Initialize
-- ------------
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- ------------
-- Font
-- ------------
config.font = wezterm.font("MonoLisa Nerd Font", { weight = "Regular", italic = false })
config.font_size = 17

-- ------------
-- Color Scheme
-- ------------
config.color_scheme = "Dark+"
config.color_schemes = {
	["Dark+"] = {
		foreground = "#f8f8f8",
		background = "#1e1e1e",
		cursor_bg = "#aeafad",
		cursor_fg = "#1e1e1e",
		cursor_border = "#52ad70",
		selection_fg = "black",
		selection_bg = "#2e4e75",
		scrollbar_thumb = "#4f4f4f",
		ansi = {
			"#000000",
			"#e06c75",
			"#98c379",
			"#ffcb6b",
			"#82aaff",
			"#ff79c6",
			"#89ddff",
			"#ffffff",
		},
		brights = {
			"#5c5c5c",
			"#ff5370",
			"#c3e88d",
			"#ffcb6b",
			"#61afef",
			"#ff79c6",
			"#89ddff",
			"#ffffff",
		},
	},
}

-- ------------
-- Tabs, Windows & More
-- ------------
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_max_width = 20
config.show_new_tab_button_in_tab_bar = false

config.clean_exit_codes = { 130 }
config.enable_scroll_bar = true

config.window_close_confirmation = "NeverPrompt"

return config
