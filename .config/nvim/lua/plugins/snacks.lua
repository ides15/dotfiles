return {
    "folke/snacks.nvim",
    opts = {
        statuscolumn = {
            left = { "mark", "sign", "git" },
            right = { "fold" },
            folds = {
                open = true, -- show open fold icons
            },
        },
        bigfile = {
            enabled = false,
        },
    },
}
