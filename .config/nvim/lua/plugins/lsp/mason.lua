local lspconfig = require("lspconfig")

require("mason").setup({})

-- local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("mason-lspconfig").setup({
    ensure_installed = {
        -- "harper_ls",
        "lua_ls",
        "vtsls",
        "eslint",
        "jsonls",
        "graphql",
        "bashls",
        "marksman",
        "yamlls",
    },
    handlers = {
        function(server_name)
            lspconfig[server_name].setup({
                -- capabilities = capabilities,
            })
        end,

        jsonls = function()
            lspconfig.jsonls.setup({
                settings = {
                    jsonls = {
                        schemas = require("schemastore").json.schemas(),
                        validate = {
                            enable = true,
                        },
                    },
                },
            })
        end,

        harper_ls = function()
            lspconfig.harper_ls.setup({
                settings = {
                    ["harper-ls"] = {
                        userDictPath = "~/.config/harper-ls/dict.txt",
                        fileDictPath = "~/.config/harper-ls/file-local/",
                    },
                },
            })
        end,
    },
})
