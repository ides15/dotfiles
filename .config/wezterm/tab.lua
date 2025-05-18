local wezterm = require("wezterm")
local colors = require("colors")

local function tab_title(tab_info)
    local title = tab_info.tab_title

    if title and #title > 0 then
        return title
    end

    return tab_info.active_pane.title
end

local left_icon = wezterm.nerdfonts.ple_upper_left_triangle
local right_icon = wezterm.nerdfonts.ple_lower_right_triangle

local function format_right_status(window)
    local ws_icon_map = {
        ["work"] = wezterm.nerdfonts.seti_project,
        ["config"] = wezterm.nerdfonts.seti_config,
    }

    local kt = window:active_key_table()
    local ws = window:active_workspace()
    local ws_icon = ws_icon_map[ws] and " " .. ws_icon_map[ws] or ""

    local ws_color = colors.palette.peach
    local kt_color = colors.palette.mauve
    local bg = colors.colors.tab_bar.background

    return wezterm.format({
        { Foreground = { Color = kt_color } },
        { Text = kt and (kt .. " ") or "" },
        { Background = { Color = ws_color } },
        { Foreground = { Color = bg } },
        { Text = left_icon },
        { Foreground = { Color = bg } },
        { Text = ws_icon },
        { Background = { Color = ws_color } },
        { Foreground = { Color = bg } },
        { Text = " " .. ws .. "  " },
    })
end

local M = {}

function M.apply_to_config(config)
    config.window_decorations = "RESIZE"

    config.use_fancy_tab_bar = false
    config.tab_max_width = 30
    config.show_new_tab_button_in_tab_bar = false
    config.show_tab_index_in_tab_bar = false

    wezterm.on("format-tab-title", function(tab)
        local title = tab_title(tab)
        local first = tab.tab_index == 0

        return {
            { Text = first and "" or left_icon },
            {
                Attribute = {
                    Intensity = tab.is_active and "Bold" or "Normal",
                },
            },
            { Text = (first and "  " or " ") .. title .. " " },
            { Text = right_icon },
        }
    end)

    wezterm.on("update-right-status", function(window)
        local right_status = format_right_status(window)

        window:set_right_status(right_status)
    end)
end

return M
