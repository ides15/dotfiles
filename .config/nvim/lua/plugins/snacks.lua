return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        lazygit = {
            configure = true,
        },
    },
    keys = {
        {
            "<leader>gg",
            function()
                require("snacks").lazygit.open()
            end,
        },
    },
}
