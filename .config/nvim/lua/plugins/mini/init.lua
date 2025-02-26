return {
    "echasnovski/mini.nvim",
    version = false,
    event = "VeryLazy",
    priority = 900,
    config = function()
        require("plugins/mini/icons")
        require("plugins/mini/files")
        require("plugins/mini/pairs")
        require("plugins/mini/hipatterns")
        require("plugins/mini/splitjoin")
        require("plugins/mini/surround")
    end,
    keys = {
        {
            "<leader>e",
            function()
                local files = require("mini.files")

                if not files.close() then
                    files.open(vim.api.nvim_buf_get_name(0))
                end
            end,
            desc = "Show files",
        },
    },
}
