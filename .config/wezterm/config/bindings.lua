local wezterm = require("wezterm")
local wallpaper = require("config.wallpaper_cycler")
local M = {}

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

local act = wezterm.action

M.keys = {
	{
		key = "Enter",
		mods = "CMD",
		action = wezterm.action.ToggleFullScreen,
	},
	-- copy/paste --
	{ key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },

	{
		key = "O",
		mods = "CMD",
		action = wezterm.action.EmitEvent("toggle-opacity"),
	},
	{
		key = "W",
		mods = "CMD",
		action = wezterm.action_callback(function(window, _pane)
			wallpaper:toggle(window)
		end),
	},
	{
		key = ",",
		mods = "CMD",
		action = wezterm.action_callback(function(window, _pane)
			wallpaper:cycle_back(window)
		end),
	},
	{
		key = ".",
		mods = "CMD",
		action = wezterm.action_callback(function(window, _pane)
			wallpaper:cycle_forward(window)
		end),
	},
}

return M
