return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        delay = 750,
        spec = {
            { "<leader>f", group = "Format" },
            { "<leader>ft", group = "Toggle format-on-save" },
            { "<leader>p", group = "Pick" },
            { "<leader>s", group = "Search" },
            { "<leader>b", group = "Buffers" },
            { "<leader>g", group = "Git" },
            { "<leader>gh", group = "Hunk" },
            { "<leader>c", group = "Code" },
        },
    },
}
