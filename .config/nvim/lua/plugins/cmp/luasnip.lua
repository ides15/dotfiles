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

vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true, desc = "Expand or jump snippet" })

vim.keymap.set({ "i", "s" }, "<C-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, {
    silent = true,
    desc = "Jump backwards in snippet",
})

vim.keymap.set({ "i", "s" }, "<C-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, {
    silent = true,
    desc = "List options in snippet",
})
