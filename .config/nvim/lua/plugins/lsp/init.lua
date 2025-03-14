return {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            "williamboman/mason.nvim",
            dependencies = {
                "b0o/schemastore.nvim",
            },
        },
        {
            "williamboman/mason-lspconfig.nvim",
            -- dependencies = {
            --     "hrsh7th/cmp-nvim-lsp",
            -- },
        },
    },
    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            desc = "LSP actions",
            callback = function(event)
                -- Hover
                vim.keymap.set("n", "K", function()
                    vim.lsp.buf.hover()
                end, {
                    buffer = event.buf,
                    desc = "Hover",
                })

                -- Go to definition
                vim.keymap.set("n", "gd", function()
                    require("fzf-lua").lsp_definitions()
                end, {
                    buffer = event.buf,
                    desc = "Go to definition",
                })

                -- Go to implementation
                vim.keymap.set("n", "gi", function()
                    require("fzf-lua").lsp_implementations()
                end, {
                    buffer = event.buf,
                    desc = "Go to implementation",
                })

                -- Go to references
                vim.keymap.set("n", "gr", function()
                    require("fzf-lua").lsp_references({
                        ignore_current_line = true,
                        includeDeclaration = false,
                    })
                end, {
                    buffer = event.buf,
                    desc = "Go to references",
                })

                -- Code Rename
                vim.keymap.set("n", "<leader>cr", function()
                    vim.lsp.buf.rename()
                end, {
                    buffer = event.buf,
                    desc = "Rename",
                })

                -- Code Actions
                vim.keymap.set("n", "<leader>ca", function()
                    require("fzf-lua").lsp_code_actions()
                end, {
                    buffer = event.buf,
                    desc = "Trigger code actions menu",
                })
            end,
        })

        require("plugins/lsp/mason")
    end,
}
