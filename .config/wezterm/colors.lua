local wezterm = require("wezterm")

local M = {}

local theme = "Catppuccin Mocha"

M.palette = {
    rosewater = "#f5e0dc",
    flamingo = "#f2cdcd",
    pink = "#f5c2e7",
    mauve = "#cba6f7",
    red = "#f38ba8",
    maroon = "#eba0ac",
    peach = "#fab387",
    yellow = "#f9e2af",
    green = "#a6e3a1",
    teal = "#94e2d5",
    sky = "#89dceb",
    sapphire = "#74c7ec",
    blue = "#89b4fa",
    lavender = "#b4befe",
    text = "#cdd6f4",
    subtext_1 = "#bac2de",
    subtext_0 = "#a6adc8",
    overlay_2 = "#9399b2",
    overlay_1 = "#7f849c",
    overlay_0 = "#6c7086",
    surface_2 = "#585b70",
    surface_1 = "#45475a",
    surface_0 = "#313244",
    base = "#1e1e2e",
    mantle = "#181825",
    crust = "#11111b",
}

local custom = wezterm.color.get_builtin_schemes()[theme]

custom.tab_bar.background = M.palette.base

custom.tab_bar.inactive_tab.bg_color = M.palette.overlay_0
custom.tab_bar.inactive_tab.fg_color = custom.tab_bar.background

M.colors = custom

function M.apply_to_config(config)
    config.color_schemes = {
        [theme] = custom,
    }
    config.color_scheme = theme
end

return M
