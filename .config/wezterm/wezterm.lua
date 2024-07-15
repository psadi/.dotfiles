-- ----------
-- Initialize
-- ----------
local wezterm = require("wezterm")
local mux = wezterm.mux

-- ---------------------------------
-- MacOS Start with GUI as maximized
-- ---------------------------------
wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

local config = wezterm.config_builder()

-- ----
-- Font
-- ----
config.font = wezterm.font("MonoLisa Nerd Font", { weight = "Regular", italic = false })
config.font_size = 17

-- ------------
-- Color Scheme
-- ------------
config.color_scheme = "Tokyo Night"
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
			-- With reference to https://wezfurlong.org/wezterm/config/appearance.html
			"#000000", -- black
			"#e06c75", -- maroon
			"#98c379", -- green
			"#ffcb6b", -- olive
			"#82aaff", -- navy
			"#ff79c6", --purple
			"#89ddff", -- teal
			"#ffffff", -- silver
		},
		brights = {
			"#5c5c5c", -- grey
			"#ff5370", -- red
			"#c3e88d", -- lime
			"#ffcb6b", -- yellow
			"#61afef", -- blue
			"#ff79c6", -- fuchsia
			"#89ddff", -- aqua
			"#ffffff", -- white
		},
	},
}

-- --------------------
-- Tabs, Windows & More
-- --------------------
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_max_width = 20
config.show_new_tab_button_in_tab_bar = false
config.clean_exit_codes = { 130 }
config.enable_scroll_bar = false
config.window_close_confirmation = "NeverPrompt"

-- -----------------------------------------------------
-- MacOS navigation between words using Opt + Arrow Keys
-- -----------------------------------------------------
config.keys = {
	{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
	{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
}

return config
