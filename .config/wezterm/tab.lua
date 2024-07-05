local wezterm = require("wezterm")
local colors = require("colors").colors

local function tab_title(tab_info)
	local title = tab_info.tab_title

	if title and #title > 0 then
		return title
	end

	return tab_info.active_pane.title
end

local left_icon = wezterm.nerdfonts.ple_lower_right_triangle
local right_icon = wezterm.nerdfonts.ple_upper_left_triangle
local circle = wezterm.nerdfonts.oct_circle
local plus_circle = wezterm.nerdfonts.fa_plus_circle
local minus_circle = wezterm.nerdfonts.fa_minus_circle
local x_circle = wezterm.nerdfonts.fa_times_circle

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

	create_window_action("window_close", colors.red, " " .. circle)
	create_window_action("window_close_hover", colors.red, " " .. x_circle)
	create_window_action("window_hide", colors.yellow, circle)
	create_window_action("window_hide_hover", colors.yellow, minus_circle)
	create_window_action("window_maximize", colors.green, circle .. " ")
	create_window_action("window_maximize_hover", colors.green, plus_circle .. " ")

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

	-- Right status styling
	wezterm.on("update-status", function(window)
		local date = wezterm.strftime("%A, %B %d - %I:%M %p")

		-- start showing the battery percentage warning once battery is < 11
		local BATTERY_PERCENTAGE_WARNING_THRESHOLD = 11

		local battery_text = ""
		for _, b in ipairs(wezterm.battery_info()) do
			if (b.state_of_charge * 100) < BATTERY_PERCENTAGE_WARNING_THRESHOLD then
				battery_text = " "
					.. wezterm.nerdfonts.md_battery_low
					.. " "
					.. string.format("%.0f%%", b.state_of_charge * 100)
					.. " "
			end
		end

		local right_status = {
			{ Foreground = { Color = colors.tab_bar.active_tab.bg_color } },
			{ Background = { Color = battery_text ~= "" and colors.red or colors.tab_bar.background } },
			{ Text = left_icon },

			{ Foreground = { Color = colors.tab_bar.active_tab.fg_color } },
			{ Background = { Color = colors.tab_bar.active_tab.bg_color } },
			{ Attribute = { Intensity = "Bold" } },
			{ Text = " " .. date .. " " .. wezterm.nerdfonts.oct_clock .. " " },
		}

		if battery_text ~= "" then
			local battery_percentage_warning_elements = {
				{ Foreground = { Color = colors.red } },
				{ Background = { Color = colors.tab_bar.background } },
				{ Text = left_icon },

				{ Foreground = { Color = colors.tab_bar.active_tab.fg_color } },
				{ Background = { Color = colors.red } },
				{ Attribute = { Intensity = "Bold" } },
				{ Text = battery_text },
			}

			for index, element in ipairs(battery_percentage_warning_elements) do
				table.insert(right_status, index, element)
			end
		end

		window:set_right_status(wezterm.format(right_status))
	end)
	--

	config.use_fancy_tab_bar = false
	config.tab_max_width = 30
	config.show_new_tab_button_in_tab_bar = false
	config.show_tab_index_in_tab_bar = false
end

return module
