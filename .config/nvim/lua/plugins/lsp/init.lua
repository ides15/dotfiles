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
                vim.keymap.del("n", "gri") -- Default implementations mapping

                map("n", "gr", function()
                    require("fzf-lua").lsp_references({
                        ignore_current_line = true,
                        includeDeclaration = false,
                    })
                end, { desc = "References" })
                vim.keymap.del("n", "grr") -- Default references mapping

                map("n", "cr", function()
                    vim.lsp.buf.rename()
                end, { desc = "Rename" })
                vim.keymap.del("n", "grn") -- Default rename mapping

                map("n", "ca", function()
                    require("fzf-lua").lsp_code_actions()
                end, { desc = "Actions" })
                vim.keymap.del("n", "gra") -- Default code actions mapping

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
