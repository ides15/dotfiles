local wezterm = require("wezterm")
local mux = wezterm.mux

local M = {}

---@diagnostic disable-next-line: unused-local
function M.apply_to_config(config)
    wezterm.on("gui-startup", function()
        -- Work workspace

        ---@diagnostic disable-next-line: unused-local
        local dev_tab, dev_pane, work_window =
            mux.spawn_window({ workspace = "work" })
        dev_tab:set_title("dev")

        local shell_tab = work_window:spawn_tab({})
        -- TODO check if auth'd, if not run `auth`
        -- TODO check if AWS creds assumed, if not run `isengardcli assume`
        shell_tab:set_title("shell")

        local test_tab = work_window:spawn_tab({})
        test_tab:set_title("tests")

        local ui_tab = work_window:spawn_tab({})
        ui_tab:set_title("ui")

        dev_tab:activate()

        -- Config workspace

        ---@diagnostic disable-next-line: unused-local
        local config_tab, config_pane, config_window =
            mux.spawn_window({
                workspace = "config",
                cwd = "/Users/jci/dotfiles",
            })
        config_tab:set_title("config")

        mux.set_active_workspace("work")
    end)
end

return M
