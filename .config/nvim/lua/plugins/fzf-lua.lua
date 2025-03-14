return {
    "ibhagwan/fzf-lua",
    dependencies = { "echasnovski/mini.nvim" },
    lazy = true,
    config = function()
        local actions = require("fzf-lua.actions")

        local rg_opts = {
            "--column",
            "--line-number",
            "--no-heading",
            "--color=always",
            "--smart-case",
            "--max-columns=4096",
            "--glob '!**/__tests__/**'",
            "--glob '!**.test.tsx'",
            "--glob '!**.test.ts'",
            "--glob '!**.stories.tsx'",
            "--glob '!pnpm-lock.yaml'",
            "-e",
        }

        require("fzf-lua").setup({
            defaults = {
                git_icons = true,
                file_icons = true,
            },
            winopts = {
                height = 0.5,
                width = 0.85,
                preview = {
                    hidden = "hidden",
                },
            },
            fzf_opts = {
                ["--cycle"] = "",
            },
            files = {
                formatter = { "path.filename_first", 2 },
                actions = {
                    ["ctrl-g"] = { actions.toggle_ignore },
                    ["ctrl-h"] = { actions.toggle_hidden },
                },
            },
            grep = {
                rg_opts = table.concat(rg_opts, " "),
                actions = {
                    ["ctrl-g"] = { actions.toggle_ignore },
                    ["ctrl-h"] = { actions.toggle_hidden },
                },
            },
            lsp = {
                jump1 = true,
                formatter = { "path.filename_first", 2 },
            },
            hls = {},
        })

        vim.api.nvim_set_hl(
            0,
            "FzfLuaBackdrop",
            { link = "FzfLuaNormal" }
        )
    end,
    keys = {
        {
            "<leader>f",
            function()
                vim.api.nvim_exec_autocmds(
                    "User",
                    { pattern = "PickerFiles" }
                )
                require("fzf-lua").files()
            end,
            desc = "List files",
        },
        {
            "<leader>/",
            function()
                vim.api.nvim_exec_autocmds(
                    "User",
                    { pattern = "PickerLiveGrep" }
                )
                require("fzf-lua").live_grep()
            end,
            desc = "Grep files",
        },
        {
            "<leader>r",
            function()
                vim.api.nvim_exec_autocmds(
                    "User",
                    { pattern = "PickerResume" }
                )
                require("fzf-lua").resume()
            end,
            desc = "Resume last picker",
        },
        {
            "<leader>.",
            function()
                vim.api.nvim_exec_autocmds(
                    "User",
                    { pattern = "PickerBuffers" }
                )
                require("fzf-lua").buffers()
            end,
            desc = "List open buffers",
        },
        {
            "<leader>h",
            function()
                vim.api.nvim_exec_autocmds(
                    "User",
                    { pattern = "PickerBuffers" }
                )
                require("fzf-lua").highlights()
            end,
            desc = "List highlights",
        },
    },
}
