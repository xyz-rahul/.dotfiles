local wezterm = require("wezterm")
local mytable = require("mystdlib").mytable

local wallpapers_list = wezterm.glob(wezterm.home_dir .. "/waifu/*")
local Wallpaper = require("wallpaper"):init(wallpapers_list)

local config = wezterm.config_builder()

-- config.background = Wallpaper:background()

----------------- OPACITY ----------------
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

----------------- CONFIG ----------------
-- config.debug_key_events = true

config.keys = {
	{
		key = "Enter",
		mods = "CMD",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "O",
		mods = "CMD",
		action = wezterm.action.EmitEvent("toggle-opacity"),
	},
	-- copy/paste --
	{ key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
}

local full_config = mytable.merge_all(
	require("appearance"),
	config,
	{} -- so the last table can have an ending comma for git diffs :)
)
return full_config
-- for k,v in pairs(second_table) do first_table[k] = v end
