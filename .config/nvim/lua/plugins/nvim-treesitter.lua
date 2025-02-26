return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = "all",
            auto_install = true,

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-L>",
                    node_incremental = "<C-L>",
                    scope_incremental = "<C-K>",
                    node_decremental = "<C-H>",
                },
            },

            indent = {
                enable = true,
            },
        })
    end,
}
