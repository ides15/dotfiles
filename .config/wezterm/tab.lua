local wezterm = require("wezterm")
local colors = require("colors").colors

local red = colors.ansi[2]
local yellow = colors.ansi[4]
local green = colors.ansi[3]

local function tab_title(tab_info)
	local title = tab_info.tab_title

	if title and #title > 0 then
		return title
	end

	return tab_info.active_pane.title
end

local left_icon = wezterm.nerdfonts.ple_lower_right_triangle
local right_icon = wezterm.nerdfonts.ple_upper_left_triangle
local circle = wezterm.nerdfonts.cod_circle_large
local plus_circle = wezterm.nerdfonts.cod_add
local minus_circle = wezterm.nerdfonts.cod_dash
local x_circle = wezterm.nerdfonts.cod_close

local module = {}

function module.apply_to_config(config)
	-- Window actions
	local window_actions = {}

	local function create_window_action(action, color, content)
		window_actions[action] = wezterm.format({
			{ Background = { Color = colors.background } },
			{ Foreground = { Color = color } },
			{ Text = content .. " " },
		})
	end

	create_window_action("window_close", red, " " .. circle)
	create_window_action("window_close_hover", red, " " .. x_circle)
	create_window_action("window_hide", yellow, circle)
	create_window_action("window_hide_hover", yellow, minus_circle)
	create_window_action("window_maximize", green, circle .. " ")
	create_window_action("window_maximize_hover", green, plus_circle .. " ")

	config.tab_bar_style = window_actions

	config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
	config.integrated_title_button_style = "Windows"
	config.integrated_title_button_alignment = "Left"
	config.integrated_title_button_color = "Auto"
	config.integrated_title_buttons = { "Close", "Hide", "Maximize" }
	--

	-- Tab styling
	wezterm.on("format-tab-title", function(tab)
		local title = tab_title(tab)

		local tab_type = tab.is_active and "active_tab" or "inactive_tab"

		return {
			{ Foreground = { Color = colors.tab_bar[tab_type].bg_color } },
			{ Background = { Color = colors.tab_bar.background } },
			{ Text = left_icon },

			{ Background = { Color = colors.tab_bar[tab_type].bg_color } },
			{ Foreground = { Color = colors.tab_bar[tab_type].fg_color } },
			{ Text = " " .. title .. " " },

			{ Foreground = { Color = colors.tab_bar[tab_type].bg_color } },
			{ Background = { Color = colors.tab_bar.background } },
			{ Text = right_icon },
		}
	end)
	--

	config.use_fancy_tab_bar = false
	config.tab_max_width = 30
	config.show_new_tab_button_in_tab_bar = false
	config.show_tab_index_in_tab_bar = false

	-- Show which key table is active in the status area
	wezterm.on("update-right-status", function(window)
		local name = window:active_key_table()
		if name then
			name = name
		end
		window:set_right_status(name or "")
	end)
end

return module
