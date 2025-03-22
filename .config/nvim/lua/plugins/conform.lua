local function toggle_format_on_save(global)
    local context = global and "g" or "b"
    local context_name = global and "Global" or "Buffer"

    local message = "Format on save: "

    if vim[context].disable_format_on_save then
        vim.b.disable_format_on_save = false
        vim.g.disable_format_on_save = false
        message = message .. "Enabled"
    else
        vim[context].disable_format_on_save = true
        message = message .. "Disabled"
    end

    print(message .. " (" .. context_name .. ")")
end

return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>cff",
            function()
                require("conform").format({ async = true })
            end,
            desc = "Format file",
        },
        {
            "<leader>cfb",
            function()
                toggle_format_on_save(false)
            end,
            desc = "Toggle format-on-save (buffer)",
        },
        {
            "<leader>cfg",
            function()
                toggle_format_on_save(true)
            end,
            desc = "Toggle format-on-save (global)",
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
        default_format_opts = {
            lsp_format = "fallback",
        },
        format_on_save = function(bufnr)
            if
                vim.g.disable_format_on_save
                or vim.b[bufnr].disable_format_on_save
            then
                return
            end

            return {
                timeout_ms = 500,
            }
        end,
    },
}
