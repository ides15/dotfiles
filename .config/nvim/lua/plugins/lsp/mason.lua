local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local schema_store = require("schemastore")

mason.setup({
    ui = {
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
        "basedpyright",
        "bashls",
        "efm",
        "graphql",
        "jsonls",
        "lua_ls",
        "marksman",
        "yamlls",
        "tsgo",
        "biome",
    },
    handlers = {
        function(server_name)
            lspconfig[server_name].setup({})
        end,
        efm = function() end,
        jsonls = function()
            lspconfig.jsonls.setup({
                settings = {
                    json = {
                        schemas = schema_store.json.schemas(),
                        validate = { enable = true },
                    },
                },
            })
        end,
        yamlls = function()
            lspconfig.yamlls.setup({
                settings = {
                    yaml = {
                        schemaStore = {
                            enable = false,
                            url = "",
                        },
                        schemas = schema_store.yaml.schemas(),
                    },
                },
            })
        end,
    },
})

-- efm setup (must be outside mason-lspconfig handler)
local oxlint = {
    lintCommand = "pnpm oxlint --format unix ${INPUT}",
    lintStdin = false,
    lintFormats = { "%f:%l:%c: %m" },
    lintSource = "oxlint",
    lintOnSave = true,
    lintAfterOpen = true,
}

local efm_languages = {
    javascript = { oxlint },
    javascriptreact = { oxlint },
    typescript = { oxlint },
    typescriptreact = { oxlint },
}

vim.lsp.config("efm", {
    filetypes = vim.tbl_keys(efm_languages),
    root_markers = { "package.json", ".git" },
    init_options = { documentFormatting = false },
    settings = {
        rootMarkers = { "package.json", ".git/" },
        languages = efm_languages,
    },
})
vim.lsp.enable("efm")
