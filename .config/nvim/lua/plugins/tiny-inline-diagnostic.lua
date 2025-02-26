return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    opts = {
        preset = "classic",
    },
    config = function(_, opts)
        vim.diagnostic.config({
            virtual_text = false,
        })

        require("tiny-inline-diagnostic").setup(opts)
    end,
}
