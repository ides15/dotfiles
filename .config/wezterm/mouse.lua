local M = {}

function M.apply_to_config(config)
    -- config.disable_default_mouse_bindings = true
    config.swallow_mouse_click_on_window_focus = false

    config.mouse_wheel_scrolls_tabs = false

    config.mouse_bindings = {}
end

return M
