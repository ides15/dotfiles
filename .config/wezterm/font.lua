local wezterm = require("wezterm")

local M = {}

function M.apply_to_config(config)
    config.font = wezterm.font({
        family = "GeistMono Nerd Font", -- default
        -- family = "Hack Nerd Font", -- not bad, kinda short
        -- family = "0xProto Nerd Font", -- interesting, ligatures a little aggressive but very round
        -- family = "FiraMono Nerd Font", -- 0xProto with fewer ligatures
        -- family = "JetBrainsMono Nerd Font", -- Taller, similar to FiraMono
    })
    config.font_size = 13
    config.freetype_load_flags = "NO_HINTING"
end

return M
