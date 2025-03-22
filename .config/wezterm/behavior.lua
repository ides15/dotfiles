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

    -- How far user can scroll back in history
    config.scrollback_lines = 100000

    -- Only show a little padding on top
    config.window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    }
end

return module
