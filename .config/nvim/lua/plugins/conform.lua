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
            "<leader>ff",
            function()
                require("conform").format({ async = true })
            end,
            desc = "Format file",
        },
        {
            "<leader>ftb",
            function()
                toggle_format_on_save(false)
            end,
            desc = "Toggle format-on-save (buffer)",
        },
        {
            "<leader>ftg",
            function()
                toggle_format_on_save(true)
            end,
            desc = "Toggle format-on-save (global)",
        },
    },
    opts = {
        formatters = {
            biome = {
                condition = function(self, ctx)
                    return vim.fs.find(
                        { "biome.json", "biome.jsonc" },
                        {
                            upward = true,
                            path = ctx.dirname,
                        }
                    )[1] ~= nil
                end,
            },
            kulala = {
                command = "kulala-fmt",
                args = { "format", "$FILENAME" },
                stdin = false,
            },
            oxfmt = {
                ---@diagnostic disable-next-line: unused-local
                prepend_args = function(self, ctx)
                    local config = vim.fs.find({
                        ".oxfmtrc.json",
                        ".oxfmtrc.jsonc",
                        "oxfmt.config.ts",
                    }, {
                        upward = true,
                        path = ctx.dirname,
                    })[1]

                    if config then
                        return { "--config", config }
                    end

                    return {}
                end,
            },
        },
        formatters_by_ft = {
            lua = { "stylua" },
            javascript = { "biome", "oxfmt", "prettierd" },
            typescript = { "biome", "oxfmt", "prettierd" },
            javascriptreact = { "biome", "oxfmt", "prettierd" },
            typescriptreact = { "biome", "oxfmt", "prettierd" },
            markdown = { "oxfmt", "prettierd" },
            python = {
                -- To fix auto-fixable lint errors.
                "ruff_fix",
                -- To run the Ruff formatter.
                "ruff_format",
                -- To organize the imports.
                "ruff_organize_imports",

                -- Run all formatters
                stop_after_first = false,
            },
            bash = { "shfmt" },
            sh = { "shfmt" },
            toml = { "taplo" },
            gitconfig = { "taplo" },
            graphql = { "oxfmt", "prettierd" },
            http = { "kulala" },
            yaml = { "oxfmt", "prettierd" },
            json = { "biome", "oxfmt", "prettierd" },
            jsonc = { "biome", "oxfmt", "prettierd" },
            html = { "oxfmt", "prettierd" },
        },
        default_format_opts = {
            lsp_format = "fallback",
            stop_after_first = true,
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
