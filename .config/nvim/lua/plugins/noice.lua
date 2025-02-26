return {
    "folke/noice.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    event = "VeryLazy",
    opts = {
        routes = {
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                    find = "written",
                },
                opts = {
                    skip = true,
                },
            },
        },
        cmdline = {
            format = {
                cmdline = {
                    title = "Command",
                },
                help = {
                    icon = "󰋖",
                },
                search_down = {
                    icon = "",
                },
            },
        },
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
            },
        },
        presets = {
            long_message_to_split = true,
        },
    },
}
