return {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
        require("marks").setup(opts)

        vim.api.nvim_set_hl(
            0,
            "MarkSignHL",
            { link = "CursorLineNr" }
        )
    end,
}
