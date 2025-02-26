local hipatterns = require("mini.hipatterns")

local short_hex_color = function(_, match)
    local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
    local hex = string.format("#%s%s%s%s%s%s", r, r, g, g, b, b)
    return hipatterns.compute_hex_color_group(hex, "bg")
end

hipatterns.setup({
    highlighters = {
        fixme = {
            pattern = "%f[%w]()FIXME()%f[%W]",
            group = "MiniHipatternsFixme",
        },
        hack = {
            pattern = "%f[%w]()HACK()%f[%W]",
            group = "MiniHipatternsHack",
        },
        todo = {
            pattern = "%f[%w]()TODO()%f[%W]",
            group = "MiniHipatternsTodo",
        },
        note = {
            pattern = "%f[%w]()NOTE()%f[%W]",
            group = "MiniHipatternsNote",
        },
        hex_color = hipatterns.gen_highlighter.hex_color(),
        short_hex_color = {
            pattern = "#%x%x%x%f[%X]",
            group = short_hex_color,
        },
    },
})
