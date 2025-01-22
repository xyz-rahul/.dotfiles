local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- OPACITY SETTINGS
local opacity = 1.0
config.window_background_opacity = opacity

-- toggle function
wezterm.on("toggle-opacity", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		-- if no override is setup, override the default opacity value with 1.0
		overrides.window_background_opacity = 0.8
	else
		-- if there is an override, make it nil so the opacity goes back to the default
		overrides.window_background_opacity = nil
	end
	window:set_config_overrides(overrides)
end)

-- FONT SETTINGS
config.font_size = 16
config.font = wezterm.font_with_fallback({
	{ family = "JetBrains Mono", weight = "Medium" },
	{ family = "Terminus", weight = "Bold" },
	"Noto Color Emoji",
})

-- COLOR SCHEME
config.color_scheme = "midnight-in-mojave"

-- TAB BAR CONFIGURATION
config.hide_tab_bar_if_only_one_tab = true
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.show_tab_index_in_tab_bar = false
config.switch_to_last_active_tab_when_closing_tab = true

-- WINDOW CONFIGURATION
config.window_close_confirmation = "NeverPrompt"
config.window_frame = {
	active_titlebar_bg = "#090909",
}

-- SCROLLBAR
config.enable_scroll_bar = true

-- KEY BINDINGS
config.keys = {
	-- Toggle Fullscreen
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
	-- Copy/Paste
	{ key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
}

return config
