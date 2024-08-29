local wezterm = require("wezterm")

local config = {
	font_size = 16,
	font = wezterm.font_with_fallback({
		{
			family = "JetBrains Mono",
			weight = "Medium",
		},
		{ family = "Terminus", weight = "Bold" },
		"Noto Color Emoji",
	}),

	color_scheme = "midnight-in-mojave",
	hide_tab_bar_if_only_one_tab = true,

	-- scrollbar
	enable_scroll_bar = true,
	--
	-- tab bar
	enable_tab_bar = true,
	use_fancy_tab_bar = false,
	show_tab_index_in_tab_bar = false,
	switch_to_last_active_tab_when_closing_tab = true,
	window_close_confirmation = "NeverPrompt",
	window_frame = {
		active_titlebar_bg = "#090909",
	},
}

return config
