local splitjoin = require("mini.splitjoin")
local gen_hook = splitjoin.gen_hook

local curly = { brackets = { "%b{}" } }
local pad_curly = gen_hook.pad_brackets(curly)

splitjoin.setup({
    mappings = {
        toggle = "gs",
    },
    join = {
        hooks_post = {
            pad_curly,
        },
    },
})
