local ls = require("luasnip")
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
}
