local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
	config.font = wezterm.font({
		family = "GeistMono Nerd Font",
	})
	config.font_size = 15
	config.freetype_load_flags = "NO_HINTING"
end

return module
