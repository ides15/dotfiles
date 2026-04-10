return {
    "nvimtools/hydra.nvim",
    keys = { { "<leader>wa", desc = "Adjust window size" } },
    config = function()
        local Hydra = require("hydra")

        Hydra({
            name = "Window Adjust",
            hint = false,
            mode = "n",
            body = "<leader>wa",
            config = {
                on_enter = function()
                    vim.cmd("echo")
                end,
                on_exit = function()
                    vim.schedule(function()
                        require("noice").cmd("dismiss")
                    end)
                end,
            },
            heads = {
                { "l", "<C-w>5>" },
                { "h", "<C-w>5<" },
                { "k", "<C-w>5+" },
                { "j", "<C-w>5-" },
                { "=", "<C-w>=", { exit = true } },
                { "<Esc>", nil, { exit = true } },
            },
        })
    end,
}
