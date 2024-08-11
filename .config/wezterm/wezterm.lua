-- ----------
-- Initialize
-- ----------
local wezterm = require("wezterm")
local mux = wezterm.mux
local config = wezterm.config_builder()

-- ---------------------------------
-- MacOS Start with GUI as maximized
-- ---------------------------------
wezterm.on("gui-startup", function()
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-- --------------------
-- Configs
-- --------------------
config.font = wezterm.font("MonoLisa Nerd Font")
config.font_size = 19
config.color_scheme_dirs = { "/Users/adithyaps/.config/wezterm/colorschemes" }
config.color_scheme = "carbonfox"
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_max_width = 20
config.show_new_tab_button_in_tab_bar = false
config.enable_scroll_bar = false
config.window_background_opacity = 10
config.macos_window_background_blur = 10
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- -----------------------------------------------------
-- MacOS navigation between words using Opt + Arrow Keys
-- -----------------------------------------------------
config.keys = {
  { key = "LeftArrow",  mods = "OPT",      action = wezterm.action({ SendString = "\x1bb" }) },
  { key = "RightArrow", mods = "OPT",      action = wezterm.action({ SendString = "\x1bf" }) },
  { key = 'f',          mods = 'CTRL|CMD', action = wezterm.action.ToggleFullScreen }
}

return config
