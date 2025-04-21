local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local c = ls.choice_node
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
    -- RTL screen debugging
    s("sdb", {
        t("screen.debug("),
        i(1, "undefined"),
        t(", Infinity)"),
    }),
    -- Jest
    s("it", {
        fmt(
            [[
        it("{}", {}() => {{
            {}
        }})
        ]],
            {
                i(1),
                c(2, {
                    t("async "),
                    t(""),
                }),
                i(3),
            }
        ),
    }),
}
