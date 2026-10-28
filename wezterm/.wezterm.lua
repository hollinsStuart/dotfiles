-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Enable font ligatures in WezTerm
config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }
config.font_dirs = { wezterm.home_dir .. "/Library/Fonts" }
-- Previous font setup: uncomment this block to switch back.
-- config.font = wezterm.font_with_fallback({
-- 	"MesloLGS Nerd Font Mono",
-- 	"Sarasa Term SC Nerd",
-- })

-- Current font setup.
config.font = wezterm.font_with_fallback({
	"JetBrainsMono Nerd Font Mono",
	"Symbols Nerd Font Mono",
	"Sarasa Term SC Nerd",
})

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

config.initial_cols = 120
config.initial_rows = 36

config.window_background_opacity = 0.75
config.macos_window_background_blur = 25

-- Keep an explicit theme background underneath the adjustable black shade.
-- Custom background layers replace the ordinary theme fill in this WezTerm version.
local sunglasses_base_opacity = config.window_background_opacity
local sunglasses_base_color = wezterm.color.get_builtin_schemes()[config.color_scheme].background
local sunglasses_default = 0.20

local function sunglasses_background(strength)
	return {
		{
			source = { Color = sunglasses_base_color },
			width = "100%",
			height = "100%",
			opacity = sunglasses_base_opacity,
		},
		{
			source = { Color = "#000000" },
			width = "100%",
			height = "100%",
			opacity = strength,
		},
	}
end
config.background = sunglasses_background(sunglasses_default)

local function sunglasses_strength(window)
	local overrides = window:get_config_overrides() or {}
	local layers = overrides.background
	-- Read the old single-layer override too, so existing windows migrate cleanly.
	local shade = layers and (layers[2] or layers[1])
	return shade and shade.opacity or sunglasses_default
end

local function sunglasses_status(strength)
	local opacity = 1 - (1 - sunglasses_base_opacity) * (1 - strength)
	return string.format("墨镜 %.1f%% · 基础不透明度 %.0f%% · 合成不透明度 %.2f%%",
		strength * 100, sunglasses_base_opacity * 100, opacity * 100)
end

local function set_sunglasses(window, strength)
	strength = math.floor(math.max(0, math.min(1, strength)) * 1000 + 0.5) / 1000
	local overrides = window:get_config_overrides() or {}
	overrides.background = sunglasses_background(strength)
	window:set_config_overrides(overrides)
	window:toast_notification("WezTerm 墨镜", sunglasses_status(strength), nil, 1500)
end

local function adjust_sunglasses(step)
	return wezterm.action_callback(function(window)
		local current = sunglasses_strength(window)
		local strength = step and current + step or (current > 0 and 0 or sunglasses_default)
		set_sunglasses(window, strength)
	end)
end

local inspect_sunglasses = wezterm.action_callback(function(window, pane)
	window:perform_action(wezterm.action.PromptInputLine({
		description = sunglasses_status(sunglasses_strength(window))
			.. "\n输入墨镜浓度 0–100；0 恢复基础背景，100 完全遮黑。Esc 取消。",
		action = wezterm.action_callback(function(win, _, line)
			if not line or line:match("^%s*$") then
				return
			end
			local percent = tonumber(line)
			if not percent or percent ~= percent or percent < 0 or percent > 100 then
				win:toast_notification("WezTerm 墨镜", "请输入 0 到 100 之间的数字", nil, 1500)
				return
			end
			set_sunglasses(win, percent / 100)
		end),
	}), pane)
end)

-- Fix old overrides on reload; setting overrides emits this event again,
-- so only update when the base layer is missing or its configured opacity changed.
wezterm.on("window-config-reloaded", function(window)
	local overrides = window:get_config_overrides() or {}
	local layers = overrides.background
	if layers and (#layers ~= 2 or layers[1].opacity ~= sunglasses_base_opacity) then
		overrides.background = sunglasses_background(sunglasses_strength(window))
		window:set_config_overrides(overrides)
	end
end)

config.keys = {
	{ key = "DownArrow", mods = "CMD|SHIFT", action = adjust_sunglasses(0.05) },
	{ key = "UpArrow", mods = "CMD|SHIFT", action = adjust_sunglasses(-0.05) },
	{ key = "phys:B", mods = "CMD|SHIFT", action = adjust_sunglasses(nil) },
	{ key = "phys:B", mods = "CMD|ALT", action = inspect_sunglasses },
}

-- Show tab bar only when there are multiple tabs
config.hide_tab_bar_if_only_one_tab = true

-- and finally, return the configuration to wezterm
return config
