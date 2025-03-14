local function findFiles()
    vim.api.nvim_exec_autocmds("User", { pattern = "PickerFiles" })
    require("fzf-lua").files()
end

local function findBuffers()
    vim.api.nvim_exec_autocmds("User", { pattern = "PickerBuffers" })
    require("fzf-lua").buffers()
end

local function searchFiles()
    vim.api.nvim_exec_autocmds("User", { pattern = "PickerLiveGrep" })
    require("fzf-lua").live_grep()
end

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
            "<leader>,",
            findFiles,
            desc = "Find files",
        },
        {
            "<leader>ff",
            findFiles,
            desc = "Find files",
        },
        {
            "<leader>.",
            findBuffers,
            desc = "Find open buffers",
        },
        {
            "<leader>fb",
            findBuffers,
            desc = "Find open buffers",
        },
        {
            "<leader>/",
            searchFiles,
            desc = "Search files",
        },
        {
            "<leader>sf",
            searchFiles,
            desc = "Search files",
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
            "<leader>fh",
            function()
                vim.api.nvim_exec_autocmds(
                    "User",
                    { pattern = "PickerBuffers" }
                )
                require("fzf-lua").highlights()
            end,
            desc = "Find highlights",
        },
    },
}
