local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	local gui_window = window:gui_window()
	gui_window:perform_action(wezterm.action.ToggleFullScreen, pane)
end)

config.color_scheme = "Tokyo Night"
config.font = wezterm.font("MonoLisa Nerd Font")
config.font_size = 16
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.window_decorations = "NONE"
config.window_close_confirmation = "NeverPrompt"
config.native_macos_fullscreen_mode = true

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.keys = {
	{ key = "T", mods = "CTRL", action = wezterm.action.ShowTabNavigator },
	{ key = "[", mods = "CTRL", action = act.ActivateTabRelative(-1) },
	{ key = "]", mods = "CTRL", action = act.ActivateTabRelative(1) },
	{ key = "t", mods = "CTRL", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "{", mods = "CTRL", action = act.MoveTabRelative(-1) },
	{ key = "}", mods = "CTRL", action = act.MoveTabRelative(1) },
}

return config
