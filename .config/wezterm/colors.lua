local wezterm = require("wezterm")

local module = {}

local colors = {
	foreground = "#E1D4D4",
	background = "#1A1825",
	cursor_fg = "#1A1825",
	cursor_bg = "#E7DDDD",
	cursor_border = "#1A1825",
	selection_fg = "#E1D4D4",
	selection_bg = "#523A39",
	ansi = {
		"#1A1825",
		"#EB7193",
		"#317490",
		"#F6C074",
		"#9CCFD8",
		"#C4A7E7",
		"#9CCFD8",
		"#E1D4D4",
	},
	brights = {
		"#3A3651",
		"#F289A4",
		"#358DAF",
		"#F9CA8E",
		"#94DAE6",
		"#CEB3EF",
		"#94DAE6",
		"#BF9B99",
	},
}

colors.tab_bar = {
	background = colors.background,
	active_tab = {
		bg_color = colors.foreground,
		fg_color = colors.background,
	},
	inactive_tab = {
		bg_color = colors.background,
		fg_color = colors.foreground,
	},
}

module.colors = colors

local kanagawa = {
	force_reverse_video_cursor = true,
	colors = {
		foreground = "#dcd7ba",
		background = "#1f1f28",

		cursor_bg = "#c8c093",
		cursor_fg = "#c8c093",
		cursor_border = "#c8c093",

		selection_fg = "#c8c093",
		selection_bg = "#2d4f67",

		scrollbar_thumb = "#16161d",
		split = "#16161d",

		ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
		brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
		indexed = { [16] = "#ffa066", [17] = "#ff5d62" },

		tab_bar = {
			background = "#1f1f28",
			active_tab = {
				bg_color = "#dcd7ba",
				fg_color = "#1f1f28",
			},
			inactive_tab = {
				bg_color = "#1f1f28",
				fg_color = "#dcd7ba",
			},
		},
	},
}

function module.apply_to_config(config)
	-- config.colors = colors

	config.colors = kanagawa.colors
	config.force_reverse_video_cursor = kanagawa.force_reverse_video_cursor
end

return module
