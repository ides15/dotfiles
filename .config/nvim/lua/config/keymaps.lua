vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local set = vim.keymap.set

set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Open Lazy" })
set("n", "<leader>m", "<cmd>Mason<cr>", { desc = "Open Mason" })
set(
    { "i", "n" },
    "<esc>",
    "<cmd>noh<cr><esc>",
    { desc = "Escape and clear hlsearch" }
)
set(
    "n",
    "<leader>bd",
    "<cmd>bd<cr>",
    { desc = "Delete current buffer" }
)
set(
    "n",
    "<leader>bo",
    "<cmd>%bd|e#<cr>",
    { desc = "Delete all other buffers" }
)

local function on_exit(_, code, _)
    if code ~= 0 then
        return
    end

    vim.api.nvim_win_close(vim.api.nvim_get_current_win(), true)
end

set("n", "<leader>gg", function()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = vim.o.columns,
        height = vim.o.lines,
        col = math.floor(vim.o.columns / 2),
        row = math.floor(vim.o.lines / 2),
        style = "minimal",
    })

    vim.fn.termopen("lazygit", { on_exit = on_exit })
    vim.cmd("startinsert")
    vim.cmd("setlocal cmdheight=0")
end, { desc = "LazyGit" })

set("n", "<leader>lr", "<CMD>LspRestart<CR>", {
    desc = "Restart LSP server",
})

set("n", "<leader>li", "<CMD>LspInfo<CR>", {
    desc = "Get information about connected LSP servers",
})

local function get_buf_name_path(modifiers)
    local buf_full_path = vim.api.nvim_buf_get_name(0)
    local filename = vim.fn.fnamemodify(buf_full_path, modifiers)
    print(filename)
    vim.fn.setreg("+", filename)
end

set("n", "<leader>cpf", function()
    get_buf_name_path(":t")
end, { desc = "Copy filename of buffer to clipboard" })

set("n", "<leader>cph", function()
    get_buf_name_path(":p:~")
end, { desc = "Copy path to buffer (relative to home) to clipboard" })

set("n", "<leader>cpw", function()
    get_buf_name_path(":p:.")
end, { desc = "Copy path to buffer (workspace) to clipboard" })

set("n", "<leader>cpa", function()
    get_buf_name_path(":p")
end, { desc = "Copy path to buffer (absolute) to clipboard" })
