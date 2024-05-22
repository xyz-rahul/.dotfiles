local wezterm = require("wezterm")
local config = {}

config.font_size = 16
config.font = wezterm.font_with_fallback({
	{
		family = "JetBrains Mono",
		weight = "Medium",
	},
	{ family = "Terminus", weight = "Bold" },
	"Noto Color Emoji",
})
config.color_scheme = "Seti UI (base16)"

-- in mac left opt produce alt by default
-- https://wezfurlong.org/wezterm/config/keyboard-concepts.html#macos-left-and-right-option-key
config.send_composed_key_when_left_alt_is_pressed = true

config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = 10,
	right = 10,
	top = 20,
	bottom = 0,
}

local opacities = { 1, 0.75, 0.5, 0.25 }
local opacity_index = 1

wezterm.on("toggle-opacity", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if overrides.window_background_opacity then
		opacity_index = opacity_index % #opacities + 1
		overrides.window_background_opacity = opacities[opacity_index]
	else
		overrides.window_background_opacity = opacities[1]
	end
	window:set_config_overrides(overrides)
end)

config.keys = {
	{
		key = "Enter",
		mods = "CMD",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "o",
		mods = "CTRL",
		action = wezterm.action.EmitEvent("toggle-opacity"),
	},
}

return config
