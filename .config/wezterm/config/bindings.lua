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

M.keys = {
	{
		key = "Enter",
		mods = "CMD",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "o",
		mods = "CMD",
		action = wezterm.action.EmitEvent("toggle-opacity"),
	},
	{
		key = "i",
		mods = "CMD",
		action = wezterm.action.InputSelector({
			title = "Select Background",
			choices = wallpaper:choices(),
			fuzzy = true,
			fuzzy_description = "Select Background: ",
			action = wezterm.action_callback(function(window, _pane, idx)
				---@diagnostic disable-next-line: param-type-mismatch
				wallpaper:set_img(window, tonumber(idx))
			end),
		}),
	},
}

return M
