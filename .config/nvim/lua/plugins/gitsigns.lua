return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
        on_attach = function()
            local gitsigns = require("gitsigns")

            vim.keymap.set("n", "g]", function()
                if vim.wo.diff then
                    return "]c"
                end
                vim.schedule(function()
                    gitsigns.next_hunk()
                end)
                return "<Ignore>"
            end, { expr = true, desc = "Next hunk" })

            vim.keymap.set("n", "g[", function()
                if vim.wo.diff then
                    return "[c"
                end
                vim.schedule(function()
                    gitsigns.prev_hunk()
                end)
                return "<Ignore>"
            end, { expr = true, desc = "Previous hunk" })

            vim.keymap.set(
                "n",
                "<leader>ghp",
                gitsigns.preview_hunk,
                { desc = "Preview diff" }
            )
            vim.keymap.set(
                "n",
                "<leader>ghr",
                gitsigns.reset_hunk,
                { desc = "Reset" }
            )
            vim.keymap.set("v", "<leader>ghr", function()
                gitsigns.reset_hunk({
                    vim.fn.line("."),
                    vim.fn.line("v"),
                })
            end, { desc = "Reset selection" })
            vim.keymap.set(
                "n",
                "<leader>ghR",
                gitsigns.reset_buffer,
                { desc = "Reset entire buffer" }
            )
            vim.keymap.set("n", "<leader>ghb", function()
                gitsigns.blame_line({ full = true })
            end, { desc = "Blame line" })
            vim.keymap.set(
                "n",
                "<leader>ghB",
                gitsigns.toggle_current_line_blame,
                { desc = "Toggle blame" }
            )
        end,
        current_line_blame = true,
        current_line_blame_opts = {
            virt_text_pos = "right_align",
            delay = 500,
        },
        current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
        preview_config = {
            border = "solid",
        },
    },
}
