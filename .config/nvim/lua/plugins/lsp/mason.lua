local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

mason.setup({
    ui = {
        border = "rounded",
        width = 0.9,
        height = 0.9,
    },
})

lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
    "force",
    lspconfig.util.default_config.capabilities,
    require("cmp_nvim_lsp").default_capabilities()
)

mason_lspconfig.setup({
    ensure_installed = {
        "bashls",
        "eslint",
        "graphql",
        "jsonls",
        "lua_ls",
        "marksman",
        "yamlls",
        "vtsls",
    },
    handlers = {
        function(server_name)
            lspconfig[server_name].setup({})
        end,
        vtsls = function()
            require("typescript-tools").setup({
                settings = {
                    expose_as_code_action = "all",
                    jsx_close_tag = { enable = true },
                },
            })
        end,
        eslint = function()
            lspconfig.eslint.setup({
                on_attach = function(_, bufnr)
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        command = "EslintFixAll",
                    })
                end,
            })
        end,
    },
})
