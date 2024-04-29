local module = {}

function module.apply_to_config(config)
	-- Always open WezTerm to this path
	config.default_cwd = "/Users/jci/dev"

	-- Don't adjust the window size when changing font size
	config.adjust_window_size_when_changing_font_size = false

	-- If WezTerm exits with a non 0 exit code, wait until the tab/pane is manually closed
	config.exit_behavior = "Hold"

	-- Use WebGpu GPU acceleration (Metal on MacOS)
	config.front_end = "WebGpu"

	-- When opening WezTerm, this is how big the window should be
	config.initial_cols = 150
	config.initial_rows = 40

	-- If opening a new window of WezTerm, try to instead add a new tab to an existing window instead
	config.prefer_to_spawn_tabs = true

	-- How far user can scroll back in history
	config.scrollback_lines = 100000

	-- Patterns to find during quick select mode (SUPER+SHIFT+SPACE)
	config.quick_select_patterns = {
		-- match things that look like sha1 hashes
		"[0-9a-f]{7,40}",
	}

	-- Only show a little padding on top
	config.window_padding = {
		left = "5pt",
		right = "5pt",
		top = "5pt",
		bottom = 0,
	}
end

return module
