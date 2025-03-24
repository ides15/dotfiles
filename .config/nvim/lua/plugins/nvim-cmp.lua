return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "dmitmel/cmp-cmdline-history",
    },
    config = function()
        local cmp = require("cmp")

        cmp.setup({
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "nvim_lsp_signature_help" },
                { name = "path" },
            }),
            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
            }),
            window = {
                completion = {
                    border = "rounded",
                    winhighlight = "Normal:Normal,FloatBorder:Normal",
                },
                documentation = {
                    border = "rounded",
                    winhighlight = "Normal:Normal,FloatBorder:Normal",
                },
            },
        })

        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                -- TODO: figure out how to not get these to show up so often

                -- { name = "cmdline_history" },
                -- { name = "cmdline" },
                -- { name = "path" },
            }),
        })
    end,
}
