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
    lazy = false,
    priority = 1000,
    init = function()
        vim.api.nvim_create_autocmd("DirChanged", {
            callback = function()
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    local buf = vim.api.nvim_win_get_buf(win)
                    if vim.bo[buf].filetype == "snacks_dashboard" then
                        Snacks.dashboard.update()
                        return
                    end
                end
            end,
        })
    end,
    opts = {
        lazygit = {
            configure = false,
            win = { width = 0, height = 0 },
        },
        dashboard = {
            preset = {
                keys = {
                    {
                        icon = " ",
                        key = ",",
                        desc = "Pick File",
                        action = ":lua Snacks.picker.files()",
                    },
                    {
                        icon = " ",
                        key = "/",
                        desc = "Live Grep",
                        action = ":lua Snacks.picker.grep()",
                    },
                    {
                        icon = " ",
                        key = "g",
                        desc = "Lazygit",
                        action = ":lua Snacks.lazygit()",
                    },
                    {
                        icon = " ",
                        key = "p",
                        desc = "Projects",
                        action = ":lua Snacks.picker.projects({ confirm = { 'tcd', 'close' } })",
                    },
                    {
                        icon = " ",
                        key = "q",
                        desc = "Quit",
                        action = ":qa",
                    },
                },
            },
            sections = {
                function()
                    return {
                        header = vim.fn.fnamemodify(
                            vim.fn.getcwd(),
                            ":t"
                        ),
                        padding = 1,
                        align = "center",
                    }
                end,
                { section = "keys", gap = 1 },
            },
        },
        statuscolumn = {
            left = { "mark", "sign", "git" },
            right = { "fold" },
            folds = { open = true },
        },
        bigfile = {
            enabled = false,
        },
        picker = {
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
