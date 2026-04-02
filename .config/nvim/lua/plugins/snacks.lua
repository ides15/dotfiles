local function send_to_quickfix(picker)
    local sel = picker:selected()

    if #sel == 0 then
        sel = picker:items()
    end

    local items = {}

    for _, item in ipairs(sel) do
        items[#items + 1] = {
            filename = item.file,
            lnum = item.pos and item.pos[1] or 1,
            col = item.pos and item.pos[2] or 1,
            text = item.line or "",
        }
    end

    vim.fn.setqflist(items)
    picker:close()
    vim.cmd("copen")
end

local function close_mini_files(picker)
    local ok, files = pcall(require, "mini.files")

    if ok and files.get_explorer_state() then
        files.close()
        vim.schedule(function()
            picker:focus()
        end)
    end
end

return {
    "folke/snacks.nvim",
    opts = {
        statuscolumn = {
            left = { "mark", "sign", "git" },
            right = { "fold" },
            folds = { open = true },
        },
        bigfile = {
            enabled = false,
        },
        picker = {
            auto_close = false,
            actions = {
                send_to_quickfix = send_to_quickfix,
            },
            sources = {
                cmdline = {
                    layout = { preset = "cmdline" },
                },
                grep = {
                    hidden = true,
                },
                files = {
                    hidden = true,
                },
            },
            toggles = { hidden = "." },
            layout = {
                preset = "default",
                layout = { width = 0.85, height = 0.5 },
            },
            on_show = close_mini_files,
            win = {
                input = {
                    keys = {
                        ["<M-.>"] = {
                            "toggle_hidden",
                            mode = { "i", "n" },
                        },
                        ["<C-q>"] = {
                            "send_to_quickfix",
                            mode = { "i", "n" },
                        },
                    },
                },
            },
        },
    },
    keys = {
        {
            "<leader>,",
            function()
                Snacks.picker.files()
            end,
            desc = "Pick files",
        },
        {
            "<leader>.",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Pick buffers",
        },
        {
            "<leader>/",
            function()
                Snacks.picker.grep()
            end,
            desc = "Grep files",
        },
        {
            "<leader>sh",
            function()
                Snacks.picker.help()
            end,
            desc = "Search help",
        },
        {
            "<leader>sk",
            function()
                Snacks.picker.keymaps()
            end,
            desc = "Search keymaps",
        },
        {
            "<leader>r",
            function()
                Snacks.picker.resume()
            end,
            desc = "Resume picker",
        },
    },
}
