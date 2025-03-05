local wezterm = require("wezterm")
local act = wezterm.action
local cb = wezterm.action_callback

local module = {}

function module.apply_to_config(config)
	config.disable_default_key_bindings = true

	-- Open WezTerm in a real MacOS fullscreen window
	config.native_macos_fullscreen_mode = true

	config.keys = {
		-- Splits and tabs key tables
		{
			key = "s",
			mods = "SUPER",
			action = act.ActivateKeyTable({
				name = "splits",
			}),
		},
		{
			key = "s",
			mods = "SUPER|SHIFT",
			action = act.ActivateKeyTable({
				name = "manage_splits",
			}),
		},
		{
			key = "t",
			mods = "SUPER",
			action = act.ActivateKeyTable({
				name = "tabs",
			}),
		},
		{
			key = "t",
			mods = "SUPER|SHIFT",
			action = act.ActivateKeyTable({
				name = "manage_tabs",
			}),
		},

		-- Close current pane
		{
			key = "w",
			mods = "SUPER",
			action = act.CloseCurrentPane({ confirm = false }),
		},

		-- Quit WezTerm
		{
			key = "q",
			mods = "SUPER",
			action = act.QuitApplication,
		},

		-- Activate quick select mode
		{
			key = "Space",
			mods = "SUPER|SHIFT",
			action = act.QuickSelectArgs({
				patterns = {
					-- Links
					"https?://\\S+",
					-- sha1 hashes
					"[0-9a-f]{7,40}",
					-- AWS ARNs
					"arn:[^:\n]*:[^:\n]*:[^:\n]*:[^:\n]*:[^:/\n]*[:/]?.*",
				},
				action = cb(function(window, pane)
					local selection = window:get_selection_text_for_pane(pane)

					-- Matches HTTPS link
					if string.gmatch(selection, "https?://\\S+") then
						wezterm.open_with(selection)
					else
						window:copy_to_clipboard(selection)
					end
				end),
			}),
		},

		-- Activate copy mode
		{
			key = "C",
			mods = "SUPER|SHIFT",
			action = act.ActivateCopyMode,
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

		-- Scroll to next prompt
		{
			key = "N",
			mods = "SUPER|SHIFT",
			action = act.ScrollToPrompt(1),
		},

		-- Scroll to previous prompt
		{
			key = "P",
			mods = "SUPER|SHIFT",
			action = act.ScrollToPrompt(-1),
		},
	}

	config.key_tables = {
		splits = {
			{
				key = "h",
				action = act.ActivatePaneDirection("Left"),
			},
			{
				key = "j",
				action = act.ActivatePaneDirection("Down"),
			},
			{
				key = "k",
				action = act.ActivatePaneDirection("Up"),
			},
			{
				key = "l",
				action = act.ActivatePaneDirection("Right"),
			},
		},
		manage_splits = {
			{
				key = "n",
				action = act.ActivateKeyTable({
					name = "new_split",
					one_shot = false,
				}),
			},
			{
				key = "r",
				action = act.ActivateKeyTable({
					name = "resize_split",
					one_shot = false,
				}),
			},
			{
				key = "Escape",
				action = act.PopKeyTable,
			},
		},
		new_split = {
			{
				key = "h",
				action = act.Multiple({
					act.SplitPane({ direction = "Left" }),
					act.PopKeyTable,
				}),
			},
			{
				key = "j",
				action = act.Multiple({
					act.SplitPane({ direction = "Down" }),
					act.PopKeyTable,
				}),
			},
			{
				key = "k",
				action = act.Multiple({
					act.SplitPane({ direction = "Up" }),
					act.PopKeyTable,
				}),
			},
			{
				key = "l",
				action = act.Multiple({
					act.SplitPane({ direction = "Right" }),
					act.PopKeyTable,
				}),
			},
		},
		resize_split = {
			{
				key = "h",
				action = act.AdjustPaneSize({ "Left", 5 }),
			},
			{
				key = "j",
				action = act.AdjustPaneSize({ "Down", 2 }),
			},
			{
				key = "k",
				action = act.AdjustPaneSize({ "Up", 2 }),
			},
			{
				key = "l",
				action = act.AdjustPaneSize({ "Right", 5 }),
			},
			{
				key = "Escape",
				action = act.ClearKeyTableStack,
			},
		},
		tabs = {
			{
				key = "[",
				action = act.ActivateTabRelativeNoWrap(-1),
			},
			{
				key = "]",
				action = act.ActivateTabRelativeNoWrap(1),
			},
		},
		manage_tabs = {
			{
				key = "n",
				action = act.PromptInputLine({
					description = "Enter name for new tab",
					action = cb(function(window, pane, line)
						window:perform_action(act.SpawnTab("CurrentPaneDomain"), pane)

						if line then
							window:active_tab():set_title(line)
						end

						window:perform_action(act.ClearKeyTableStack, pane)
					end),
				}),
			},
			{
				key = "i",
				action = act.PromptInputLine({
					description = "Enter name for tab",
					action = wezterm.action_callback(function(window, _, line)
						if line then
							window:active_tab():set_title(line)
						end
					end),
				}),
			},
			{
				key = "r",
				action = act.ActivateKeyTable({
					name = "reorder_tab",
					one_shot = false,
				}),
			},
			{
				key = "Escape",
				action = act.PopKeyTable,
			},
		},
		reorder_tab = {
			{
				key = "[",
				action = act.MoveTabRelative(-1),
			},
			{
				key = "]",
				action = act.MoveTabRelative(1),
			},
			{
				key = "Escape",
				action = act.ClearKeyTableStack,
			},
		},
	}
end

return module
