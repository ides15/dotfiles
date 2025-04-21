return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        {
            "folke/lazydev.nvim", -- For Lua LSP helpers
            ft = "lua",
            opts = {},
        },
        "b0o/schemastore.nvim", -- For jsonls/yamlls schemas
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        require("plugins.lsp.mason")

        vim.api.nvim_create_autocmd("LspAttach", {
            desc = "LSP actions",
            callback = function(event)
                local map = function(mode, lhs, rhs, o)
                    local opts = o or {}
                    opts.buffer = event.buf

                    vim.keymap.set(mode, lhs, rhs, opts)
                end

                map("n", "K", function()
                    vim.lsp.buf.hover({
                        border = "solid",
                    })
                end, { desc = "Hover" })

                map("n", "gd", function()
                    require("fzf-lua").lsp_definitions()
                end, { desc = "Definition" })

                map("n", "gri", function()
                    require("fzf-lua").lsp_implementations()
                end, { desc = "Implementations" })

                map("n", "grr", function()
                    require("fzf-lua").lsp_references({
                        ignore_current_line = true,
                        includeDeclaration = false,
                    })
                end, { desc = "References" })

                map("n", "grn", function()
                    vim.lsp.buf.rename()
                end, { desc = "Rename" })

                map("n", "gra", function()
                    require("fzf-lua").lsp_code_actions()
                end, { desc = "Actions" })

                local client =
                    vim.lsp.get_client_by_id(event.data.client_id)

                if not client then
                    return
                end

                -- Server-specific configurations
                local ok, module =
                    pcall(require, "plugins.lsp." .. client.name)

                if ok then
                    module.on_attach(event.buf)
                end
            end,
        })
    end,
}
