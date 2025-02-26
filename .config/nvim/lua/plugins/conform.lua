local format_args = {
    timeout_ms = 500,
    lsp_format = "fallback",
}

return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            -- Customize or remove this keymap to your liking
            "<leader>cf",
            function()
                require("conform").format(format_args)
            end,
            mode = "",
            desc = "Format buffer",
        },
    },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            javascript = { "prettierd" },
            typescript = { "prettierd" },
            javascriptreact = { "prettierd" },
            typescriptreact = { "prettierd" },
            markdown = { "prettierd" },
            python = { "black" },
            bash = { "shellcheck" },
        },
        format_on_save = format_args,
    },
}
