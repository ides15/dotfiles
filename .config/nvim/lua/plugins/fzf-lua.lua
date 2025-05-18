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

local function searchHelp()
    vim.api.nvim_exec_autocmds("User", { pattern = "PickerHelp" })
    require("fzf-lua").helptags()
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
    end,
    keys = {
        {
            "<leader>,",
            findFiles,
            desc = "Pick files",
        },
        {
            "<leader>pf",
            findFiles,
            desc = "Pick files",
        },
        {
            "<leader>.",
            findBuffers,
            desc = "Pick open buffers",
        },
        {
            "<leader>pb",
            findBuffers,
            desc = "Pick open buffers",
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
            "<leader>sh",
            searchHelp,
            desc = "Search help",
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
            "<leader>ph",
            function()
                vim.api.nvim_exec_autocmds(
                    "User",
                    { pattern = "PickerBuffers" }
                )
                require("fzf-lua").highlights()
            end,
            desc = "Pick highlights",
        },
        {
            "<leader>sc",
            function()
                vim.api.nvim_exec_autocmds(
                    "User",
                    { pattern = "PickerCommands" }
                )
                require("fzf-lua").command_history()
            end,
            desc = "Search commands",
        },
        {
            "<leader>sg",
            function()
                vim.api.nvim_exec_autocmds(
                    "User",
                    { pattern = "PickerGit" }
                )
                require("fzf-lua").git_bcommits()
            end,
            desc = "Search git history of buffer",
        },
        {
            "<leader>sk",
            function()
                vim.api.nvim_exec_autocmds(
                    "User",
                    { pattern = "PickerKeymaps" }
                )
                require("fzf-lua").keymaps()
            end,
            desc = "Search keymaps",
        },
    },
}
