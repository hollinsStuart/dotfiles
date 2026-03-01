-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Enable font ligatures in WezTerm
config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }
config.font = wezterm.font("MesloLGS Nerd Font Mono")
--- config.font = wezterm.font("JetBrains Mono")

config.font_size = 14.0

config.enable_tab_bar = false
config.window_decorations = "RESIZE"
local mocha = {
	blue = "#89b4fa",
	surface0 = "#313244",
}
config.window_frame = {
	border_left_width = 2,
	border_right_width = 2,
	border_top_height = 2,
	border_bottom_height = 2,

	border_left_color = mocha.blue,
	border_right_color = mocha.blue,
	border_top_color = mocha.blue,
	border_bottom_color = mocha.blue,
}
-- config.color_scheme = "tokyonight_moon" -- moon, storm, night, day
config.color_scheme = "Catppuccin Mocha"

-- Add window padding to give the appearance of a border
config.window_padding = {
	left = 20,
	right = 20,
	top = 20,
	bottom = 20,
}

config.window_background_opacity = 0.80
config.macos_window_background_blur = 20

-- Show tab bar only when there are multiple tabs
config.hide_tab_bar_if_only_one_tab = true

-- and finally, return the configuration to wezterm
return config
