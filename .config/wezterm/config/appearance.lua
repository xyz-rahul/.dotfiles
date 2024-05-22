local wezterm = require("wezterm")
local colors = require("colors.custom")

return {
	font_size = 14,
	font = wezterm.font_with_fallback({
		{
			family = "JetBrains Mono",
			weight = "Medium",
		},
		{ family = "Terminus", weight = "Bold" },
		"Noto Color Emoji",
	}),
	color_scheme = "Seti UI (base16)",

	-- in mac left opt produce alt by default
	-- https://wezfurlong.org/wezterm/config/keyboard-concepts.html#macos-left-and-right-option-key
	send_composed_key_when_left_alt_is_pressed = true,

	hide_tab_bar_if_only_one_tab = true,

	animation_fps = 60,
	max_fps = 60,

	-- color scheme
	colors = colors,

	-- background
	background = {
		{
			source = { File = wezterm.GLOBAL.background },
			horizontal_align = "Center",
		},
		{
			source = { Color = colors.background },
			height = "100%",
			width = "100%",
			opacity = 0.80,
		},
	},
	-- background = nil,

	-- scrollbar
	enable_scroll_bar = true,

	-- tab bar
	enable_tab_bar = true,
	use_fancy_tab_bar = false,
	tab_max_width = 25,
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
		-- font = fonts.font,
		-- font_size = fonts.font_size,
	},
	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.65,
	},
}
