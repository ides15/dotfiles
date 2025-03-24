return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        delay = 750,
        spec = {
            { "<leader>p", group = "Pick" },
            { "<leader>s", group = "Search" },
            { "<leader>b", group = "Buffers" },

            { "<leader>f", group = "Format" },
            { "<leader>ft", group = "Toggle format-on-save" },

            { "<leader>g", group = "Git" },
            { "<leader>gh", group = "Hunk" },
        },
    },
}
