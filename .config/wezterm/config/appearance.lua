local wezterm = require("wezterm")

return {
	font_size = 16,
	font = wezterm.font_with_fallback({
		{
			family = "JetBrains Mono",
			weight = "Medium",
		},
		{ family = "Terminus", weight = "Bold" },
		"Noto Color Emoji",
	}),
    color_scheme = 'midnight-in-mojave',

	-- in mac left opt produce alt by default
	-- https://wezfurlong.org/wezterm/config/keyboard-concepts.html#macos-left-and-right-option-key
	send_composed_key_when_left_alt_is_pressed = true,
	hide_tab_bar_if_only_one_tab = true,

	animation_fps = 60,
	max_fps = 60,

	-- scrollbar
	enable_scroll_bar = true,

	-- tab bar
	enable_tab_bar = true,
	use_fancy_tab_bar = false,
	show_tab_index_in_tab_bar = false,
	switch_to_last_active_tab_when_closing_tab = true,

	-- window
	window_padding = {
		left = 5,
		right = 10,
		top = 12,
		bottom = 7,
	},
	window_close_confirmation = "NeverPrompt",
	window_frame = {
		active_titlebar_bg = "#090909",
	},
}
