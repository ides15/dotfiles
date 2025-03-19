return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local cmp = require("cmp")

        cmp.setup({
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
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
    end,
}
