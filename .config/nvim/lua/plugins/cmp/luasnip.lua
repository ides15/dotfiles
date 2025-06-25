local ls = require("luasnip")
local types = require("luasnip.util.types")

local config_path = vim.fn.stdpath("config")

ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = false,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "<-", "Error" } },
            },
        },
    },
})

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").load({
    paths = config_path .. "/lua/plugins/snippets",
})
