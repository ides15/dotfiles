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
            action = act.ActivateKeyTable({ name = "splits" }),
        },
        {
            key = "t",
            mods = "SUPER",
            action = act.ActivateKeyTable({ name = "tabs" }),
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
                    local selection =
                        window:get_selection_text_for_pane(pane)

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

        -- Activate search mode
        {
            key = "f",
            mods = "SUPER",
            action = act.Search("CurrentSelectionOrEmptyString"),
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
            {
                key = "n",
                action = act.ActivateKeyTable({
                    name = "new_split",
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
                action = act.SplitPane({ direction = "Left" }),
            },
            {
                key = "j",
                action = act.SplitPane({ direction = "Down" }),
            },
            {
                key = "k",
                action = act.SplitPane({ direction = "Up" }),
            },
            {
                key = "l",
                action = act.SplitPane({ direction = "Right" }),
            },
            {
                key = "Escape",
                action = act.PopKeyTable,
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
                action = act.PopKeyTable,
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
            {
                key = "n",
                action = act.PromptInputLine({
                    description = "Enter name for new tab",
                    action = cb(function(window, pane, line)
                        window:perform_action(
                            act.SpawnTab("CurrentPaneDomain"),
                            pane
                        )

                        if line then
                            window:active_tab():set_title(line)
                        end

                        window:perform_action(act.PopKeyTable, pane)
                    end),
                }),
            },
            {
                key = "i",
                action = act.PromptInputLine({
                    description = "Enter name for tab",
                    action = wezterm.action_callback(
                        function(window, _, line)
                            if line then
                                window:active_tab():set_title(line)
                            end
                        end
                    ),
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
                action = act.PopKeyTable,
            },
        },
        copy_mode = {
            {
                key = "h",
                action = act.CopyMode("MoveLeft"),
            },
            {
                key = "j",
                action = act.CopyMode("MoveDown"),
            },
            {
                key = "k",
                action = act.CopyMode("MoveUp"),
            },
            {
                key = "l",
                action = act.CopyMode("MoveRight"),
            },
            {
                key = "w",
                action = act.CopyMode("MoveForwardWord"),
            },
            {
                key = "b",
                action = act.CopyMode("MoveBackwardWord"),
            },
            {
                key = "e",
                action = act.CopyMode("MoveForwardWordEnd"),
            },
            {
                key = "$",
                mods = "SHIFT",
                action = act.CopyMode("MoveToEndOfLineContent"),
            },
            {
                key = "0",
                action = act.CopyMode("MoveToStartOfLine"),
            },
            {
                key = "v",
                action = act.CopyMode({ SetSelectionMode = "Cell" }),
            },
            {
                key = "v",
                mods = "CTRL",
                action = act.CopyMode({ SetSelectionMode = "Block" }),
            },
            {
                key = "V",
                mods = "SHIFT",
                action = act.CopyMode({ SetSelectionMode = "Line" }),
            },
            {
                key = ",",
                action = act.CopyMode("JumpReverse"),
            },
            {
                key = ";",
                action = act.CopyMode("JumpAgain"),
            },
            {
                key = "f",
                action = act.CopyMode({
                    JumpForward = { prev_char = false },
                }),
            },
            {
                key = "F",
                mods = "SHIFT",
                action = act.CopyMode({
                    JumpBackward = { prev_char = false },
                }),
            },
            {
                key = "u",
                mods = "CTRL",
                action = act.CopyMode({ MoveByPage = -0.5 }),
            },
            {
                key = "d",
                mods = "CTRL",
                action = act.CopyMode({ MoveByPage = 0.5 }),
            },
            {
                key = "y",
                action = act.Multiple({
                    { CopyTo = "ClipboardAndPrimarySelection" },
                    { CopyMode = "MoveToScrollbackBottom" },
                    { CopyMode = "Close" },
                }),
            },
            {
                key = "G",
                mods = "SHIFT",
                action = act.CopyMode("MoveToScrollbackBottom"),
            },
            {
                key = "Escape",
                action = act.Multiple({
                    { CopyMode = "MoveToScrollbackBottom" },
                    { CopyMode = "Close" },
                }),
            },
        },
        search_mode = {
            {
                key = "n",
                mods = "SUPER",
                action = act.CopyMode("NextMatch"),
            },
            {
                key = "p",
                mods = "SUPER",
                action = act.CopyMode("PriorMatch"),
            },
            {
                key = "r",
                mods = "SUPER",
                action = act.CopyMode("CycleMatchType"),
            },
            {
                key = "Enter",
                action = act.Multiple({
                    { CopyMode = "ClearPattern" },
                    { CopyMode = "ClearSelectionMode" },
                    act.ActivateCopyMode,
                }),
            },
            {
                key = "Escape",
                action = act.Multiple({
                    { CopyMode = "ClearPattern" },
                    { CopyMode = "ClearSelectionMode" },
                    act.ActivateCopyMode,
                }),
            },
        },
    }
end

return module
