return {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
        require("illuminate").configure({
            providers = {
                "lsp",
                -- "treesitter",
                -- "regex",
            },
            delay = 500,
            min_count_to_highlight = 2,

            filetype_overrides = {
                ["json"] = {
                    providers = { "regex" },
                },
            },
        })

        vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
        vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
        vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
    end,
}
