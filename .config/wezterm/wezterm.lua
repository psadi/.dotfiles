-- ----------
-- Initialize
-- ----------
local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action
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
config.color_scheme_dirs = { "/Users/adithyaps/.config/wezterm/themes" }
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
  top = 1,
  bottom = 0,
}
config.window_close_confirmation = "AlwaysPrompt"
config.default_workspace = "home"
-- -----------------------------------------------------
-- MacOS Keybindings
-- -----------------------------------------------------
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  { key = "LeftArrow",  mods = "OPT",      action = wezterm.action({ SendString = "\x1bb" }) },
  { key = "RightArrow", mods = "OPT",      action = wezterm.action({ SendString = "\x1bf" }) },
  { key = 'f',          mods = 'CTRL|CMD', action = wezterm.action.ToggleFullScreen },
  { key = "C",          mods = "LEADER",   action = act.ActivateCopyMode },
  { key = "-",          mods = "LEADER",   action = act.SplitVertical { domain = "CurrentPaneDomain" } },
  { key = "|",          mods = "LEADER",   action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
  { key = "h",          mods = "LEADER",   action = act.ActivatePaneDirection("Left") },
  { key = "j",          mods = "LEADER",   action = act.ActivatePaneDirection("Up") },
  { key = "k",          mods = "LEADER",   action = act.ActivatePaneDirection("Down") },
  { key = "l",          mods = "LEADER",   action = act.ActivatePaneDirection("Right") },
  { key = "x",          mods = "LEADER",   action = act.CloseCurrentPane { confirm = true } },
  { key = "s",          mods = "LEADER",   action = act.RotatePanes "Clockwise" },
  { key = "R",          mods = "LEADER",   action = act.ActivateKeyTable { name = "resize_pane", one_shot = false } },
  { key = "n",          mods = "LEADER",   action = act.SpawnTab("CurrentPaneDomain") },
  { key = "[",          mods = "LEADER",   action = act.ActivateTabRelative(-1) },
  { key = "]",          mods = "LEADER",   action = act.ActivateTabRelative(1) },
  { key = "t",          mods = "LEADER",   action = act.ShowTabNavigator }
}

config.key_tables = {
  resize_pane = {
    { key = "h",      action = act.AdjustPaneSize { "Left", 1 } },
    { key = "j",      action = act.AdjustPaneSize { "Up", 1 } },
    { key = "k",      action = act.AdjustPaneSize { "Down", 1 } },
    { key = "l",      action = act.AdjustPaneSize { "Right", 1 } },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter",  action = "PopKeyTable" },
  }
}

return config
