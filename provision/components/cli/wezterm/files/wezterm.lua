local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font_size = 10
config.font = wezterm.font 'FiraCode Nerd Font'
config.color_scheme = 'GruvboxDark'

config.enable_tab_bar = false

config.window_background_opacity = 0.9

config.default_prog = { 'pwsh', '-NoLogo' }

return config