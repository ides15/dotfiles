return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
        on_attach = function()
            local gitsigns = require("gitsigns")

            vim.keymap.set("n", "<leader>ghp", gitsigns.preview_hunk)
            vim.keymap.set("n", "<leader>ghr", gitsigns.reset_hunk)
            vim.keymap.set("v", "<leader>ghr", function()
                gitsigns.reset_hunk({
                    vim.fn.line("."),
                    vim.fn.line("v"),
                })
            end)
            vim.keymap.set("n", "<leader>ghR", gitsigns.reset_buffer)
        end,
        current_line_blame = true,
        current_line_blame_opts = {
            virt_text_pos = "right_align",
            delay = 500,
        },
        current_line_blame_formatter = "<author>, <author_time:%R>",
    },
    config = function(_, opts)
        require("gitsigns").setup(opts)

        vim.api.nvim_set_hl(
            0,
            "GitSignsCurrentLineBlame",
            { link = "Comment" }
        )
    end,
}
