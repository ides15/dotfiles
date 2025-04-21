return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        -- For normal completion
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-path",

        -- For : completion
        "hrsh7th/cmp-cmdline",
        "dmitmel/cmp-cmdline-history",

        -- For / completion
        "hrsh7th/cmp-buffer",

        -- Snippets
        "saadparwaiz1/cmp_luasnip",
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp",
            dependencies = { "rafamadriz/friendly-snippets" },
        },
    },
    event = "InsertEnter",
    config = function()
        local cmp = require("cmp")
        local ls = require("luasnip")

        require("plugins.cmp.luasnip")

        cmp.setup({
            sources = cmp.config.sources({
                { name = "nvim_lsp_signature_help" },
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "path" },
                {
                    name = "lazydev",
                    group_index = 0, -- set group index to 0 to skip loading LuaLS completions
                },
            }),
            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping({
                    i = function(fallback)
                        if
                            cmp.visible() and cmp.get_active_entry()
                        then
                            cmp.confirm({
                                behavior = cmp.ConfirmBehavior.Replace,
                                select = false,
                            })
                        else
                            fallback()
                        end
                    end,
                    s = cmp.mapping.confirm({ select = true }),
                    c = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                }),
                -- TODO: only show if cmp.visible()
                ["<C-n>"] = cmp.mapping.select_next_item({
                    behavior = cmp.SelectBehavior.Select,
                }),
                -- TODO: only show if cmp.visible()
                ["<C-p>"] = cmp.mapping.select_prev_item({
                    behavior = cmp.SelectBehavior.Select,
                }),
            }),
            snippet = {
                expand = function(args)
                    ls.lsp_expand(args.body)
                end,
            },
            formatting = {
                format = function(entry, item)
                    local icons = require("mini.icons")
                    local icon, hl_group = icons.get("lsp", item.kind)

                    if icon then
                        item.kind = icon .. "\t" .. item.kind
                        item.kind_hl_group = hl_group
                    end

                    item.menu = ({
                        nvim_lsp_signature_help = "[Signature]",
                        nvim_lsp = "[LSP]",
                        luasnip = "[LuaSnip]",
                        path = "[Path]",
                    })[entry.source.name]

                    return item
                end,
            },
            window = {
                completion = {
                    border = "solid",
                    winhighlight = "Normal:ColorColumn,FloatBorder:ColorColumn",
                },
                documentation = {
                    border = "solid",
                    winhighlight = "Normal:ColorColumn,FloatBorder:ColorColumn",
                },
            },
        })

        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        -- cmp.setup.cmdline(":", {
        --     mapping = cmp.mapping.preset.cmdline(),
        --     sources = cmp.config.sources({
        --         -- TODO: figure out how to not get these to show up so often
        --
        --         -- { name = "cmdline_history" },
        --         -- { name = "cmdline" },
        --         -- { name = "path" },
        --     }),
        -- })
    end,
}
