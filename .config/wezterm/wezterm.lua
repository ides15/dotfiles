local wezterm = require("wezterm")

local config = wezterm.config_builder()

require("colors").apply_to_config(config)
require("startup").apply_to_config(config)
require("tab").apply_to_config(config)
require("behavior").apply_to_config(config)
require("font").apply_to_config(config)
require("keys").apply_to_config(config)
require("mouse").apply_to_config(config)

return config
