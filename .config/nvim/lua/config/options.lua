-- Show number of current line
vim.opt.number = true

-- Show relative numbers
vim.opt.relativenumber = true

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Confirm when exiting a modified buffer
vim.opt.confirm = true

-- Highlight the current line
vim.opt.cursorline = true

-- Ignore case when searching
vim.opt.ignorecase = true

-- Don"t ignore case with capitals
vim.opt.smartcase = true

-- Don't show status line
vim.opt.laststatus = 0

-- Don't wrap lines
vim.opt.wrap = false

-- Use mouse
vim.opt.mouse = "a"

-- Have >=5 lines before/after cursor
vim.opt.scrolloff = 5

-- Indent with shiftwidth
vim.opt.shiftround = true

-- Use spaces
vim.opt.expandtab = true

-- 4 space indent
vim.opt.shiftwidth = 4

-- Tab is 4 spaces
vim.opt.tabstop = 4

-- Indent on new lines
vim.opt.smartindent = true

-- Don"t show mode
vim.opt.showmode = false

-- Don't show command line below statusline
-- vim.opt.cmdheight = 0

vim.opt.spelllang = { "en" }

-- When horizontal splitting, put new split below
vim.opt.splitbelow = true

-- When vertically splitting, put new split right
vim.opt.splitright = true

-- Better colors
vim.opt.termguicolors = true

-- Save edits to an undo file
vim.opt.undofile = true

-- Save up to 10k undo-s
vim.opt.undolevels = 10000

vim.opt.signcolumn = "yes"

-- Allow visual mode rectangle to select areas with no character
vim.opt.virtualedit = "block"

vim.opt.background = "dark"

-- Turn off syntax highlighting, use TS instead
vim.opt.syntax = "off"

-- -- Folding
-- vim.wo.foldmethod = "expr"
-- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
