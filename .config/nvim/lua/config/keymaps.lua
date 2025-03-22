vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set(
    "n",
    "<leader>l",
    "<cmd>Lazy<cr>",
    { desc = "Open Lazy" }
)
vim.keymap.set(
    "n",
    "<leader>m",
    "<cmd>Mason<cr>",
    { desc = "Open Mason" }
)
vim.keymap.set(
    { "i", "n" },
    "<esc>",
    "<cmd>noh<cr><esc>",
    { desc = "Escape and clear hlsearch" }
)
vim.keymap.set(
    "n",
    "<leader>bd",
    "<cmd>bd<cr>",
    { desc = "Delete all buffers except current" }
)
vim.keymap.set(
    "n",
    "<leader>bo",
    "<cmd>%bd|e#<cr>",
    { desc = "Delete all other buffers" }
)
