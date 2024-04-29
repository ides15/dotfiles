local wezterm = require("wezterm")

local module = {}

local color_scheme = "tokyonight_night"

local colors = wezterm.get_builtin_color_schemes()[color_scheme]
colors.red = "#FF5F57"
colors.yellow = "#FEBC2E"
colors.green = "#28C840"

module.colors = colors

function module.apply_to_config(config)
	config.color_scheme = color_scheme
end

return module
