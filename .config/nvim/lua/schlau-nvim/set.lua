-- nvim configuration (c) Toshiki Nakamura
-- init.lua (.config/nvim/schlau/init.lua) 
-- Basic setting for neovim (add numbers etc)

-- vim.opt.guicursor = ""
vim.opt.number = true  -- Number
vim.opt.relativenumber = true --relativenumber

vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.autoread = true
vim.opt.expandtab = true
vim.opt.wrap = false



vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

--vim.opt.scrolloff = 8
--vim.opt.isfname:append("@-@")
--vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

-- vim.cmd('syntax enable')
-- vim.cmd('filetype plugin indent on')

vim.opt.clipboard="unnamed,unnamedplus"
