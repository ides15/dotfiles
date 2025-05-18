return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "echasnovski/mini.nvim",
    },
    opts = {
        options = {
            theme = "catppuccin",
            globalstatus = true,
            section_separators = { left = "", right = "" },
            component_separators = { left = "", right = "" },
        },
        extensions = { "fzf", "lazy", "mason", "trouble" },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = { "filename" },
            lualine_x = { "filetype" },
            lualine_y = { "lsp_status" },
            lualine_z = { "location" },
        },
    },
}
