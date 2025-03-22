return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        {
            "pmizio/typescript-tools.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
        },
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

                map("n", "gi", function()
                    require("fzf-lua").lsp_implementations()
                end, { desc = "Implementations" })

                map("n", "gr", function()
                    require("fzf-lua").lsp_references({
                        ignore_current_line = true,
                        includeDeclaration = false,
                    })
                end, { desc = "References" })

                map("n", "cr", function()
                    vim.lsp.buf.rename()
                end, { desc = "Rename" })

                map("n", "ca", function()
                    require("fzf-lua").lsp_code_actions()
                end, { desc = "Actions" })
            end,
        })
    end,
}
