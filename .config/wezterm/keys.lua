local wezterm = require("wezterm")
local act = wezterm.action

local module = {}

function module.apply_to_config(config)
	config.disable_default_key_bindings = true

	-- Open WezTerm in a real MacOS fullscreen window
	config.native_macos_fullscreen_mode = true

	config.keys = {
		-- #########
		-- # Panes #
		-- #########

		-- Create new vertically split pane
		{
			key = "|",
			mods = "SUPER|SHIFT",
			action = act.SplitPane({
				direction = "Right",
				size = { Percent = 30 },
			}),
		},

		-- Close current pane
		{
			key = "w",
			mods = "SUPER",
			action = act.CloseCurrentPane({ confirm = false }),
		},

		-- Move to left pane
		{
			key = "h",
			mods = "SUPER",
			action = act.ActivatePaneDirection("Left"),
		},

		-- Move to right pane
		{
			key = "l",
			mods = "SUPER",
			action = act.ActivatePaneDirection("Right"),
		},

		-- Activate pane resize key table
		{
			key = "r",
			mods = "SUPER",
			action = act.ActivateKeyTable({
				name = "resize_pane",
				one_shot = false,
			}),
		},

		-- ########
		-- # Tabs #
		-- ########

		-- Create new tab
		{
			key = "t",
			mods = "SUPER",
			action = act.SpawnTab("CurrentPaneDomain"),
		},

		-- Close current tab
		{
			key = "W",
			mods = "SUPER|SHIFT",
			action = act.CloseCurrentTab({ confirm = false }),
		},

		-- Move to left tab
		{
			key = "H",
			mods = "SUPER|SHIFT",
			action = act.ActivateTabRelativeNoWrap(-1),
		},

		-- Move to right tab
		{
			key = "L",
			mods = "SUPER|SHIFT",
			action = act.ActivateTabRelativeNoWrap(1),
		},

		-- Activate tab reorder key table
		{
			key = "R",
			mods = "SUPER|SHIFT",
			action = act.ActivateKeyTable({
				name = "reorder_tabs",
				one_shot = false,
			}),
		},

		-- ###########
		-- # General #
		-- ###########

		-- Quit WezTerm
		{
			key = "q",
			mods = "SUPER",
			action = act.QuitApplication,
		},

		-- Make WezTerm fullscreen
		{
			key = "Enter",
			mods = "SUPER",
			action = act.ToggleFullScreen,
		},

		-- Zen mode
		{
			key = "z",
			mods = "SUPER",
			action = act.TogglePaneZoomState,
		},

		{
			key = "Space",
			mods = "SUPER|SHIFT",
			action = act.QuickSelect,
		},

		-- Copy
		{
			key = "c",
			mods = "SUPER",
			action = act.CopyTo("Clipboard"),
		},

		-- Paste
		{
			key = "v",
			mods = "SUPER",
			action = act.PasteFrom("Clipboard"),
		},

		-- Increase font size
		{
			key = "+",
			mods = "SUPER",
			action = act.IncreaseFontSize,
		},

		-- Decrease font size
		{
			key = "-",
			mods = "SUPER",
			action = act.DecreaseFontSize,
		},

		-- Debug overlay
		{
			key = "L",
			mods = "CTRL|SHIFT",
			action = act.ShowDebugOverlay,
		},

		-- Scroll up page
		{
			key = "K",
			mods = "SUPER|SHIFT",
			action = act.ScrollByLine(-30),
		},

		-- Scroll down page
		{
			key = "J",
			mods = "SUPER|SHIFT",
			action = act.ScrollByLine(30),
		},

		-- Scroll to bottom
		{
			key = "G",
			mods = "SUPER|SHIFT",
			action = act.ScrollToBottom,
		},
	}

	config.key_tables = {
		resize_pane = {
			{
				key = "h",
				action = act.AdjustPaneSize({ "Left", 5 }),
			},
			{
				key = "l",
				action = act.AdjustPaneSize({ "Right", 5 }),
			},
			{
				key = "Escape",
				action = "PopKeyTable",
			},
		},
		reorder_tabs = {
			{
				key = "h",
				action = act.MoveTabRelative(-1),
			},
			{
				key = "l",
				action = act.MoveTabRelative(1),
			},
			{
				key = "Escape",
				action = "PopKeyTable",
			},
		},
	}
end

return module
