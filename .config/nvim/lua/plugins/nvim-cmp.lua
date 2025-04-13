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
        local types = require("luasnip.util.types")
        local config_path = vim.fn.stdpath("config")

        ls.config.set_config({
            history = true,
            updateevents = "TextChanged,TextChangedI",
            enable_autosnippets = false,
            ext_opts = {
                [types.choiceNode] = {
                    active = {
                        virt_text = { { "<-", "Error" } },
                    },
                },
            },
        })

        vim.keymap.set({ "i", "s" }, "<C-k>", function()
            if ls.expand_or_jumpable() then
                ls.expand_or_jump()
            end
        end, { silent = true, desc = "Expand or jump snippet" })

        vim.keymap.set({ "i", "s" }, "<C-j>", function()
            if ls.jumpable(-1) then
                ls.jump(-1)
            end
        end, {
            silent = true,
            desc = "Jump backwards in snippet",
        })

        vim.keymap.set({ "i", "s" }, "<C-l>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end, {
            silent = true,
            desc = "List options in snippet",
        })

        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_lua").load({
            paths = config_path .. "/lua/plugins/snippets",
        })

        cmp.setup({
            sources = cmp.config.sources({
                { name = "nvim_lsp_signature_help" },
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "path" },
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
