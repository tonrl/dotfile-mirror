-- nvim configuration (c) Toshiki Nakamura
-- init.lua (.config/nvim/schlau/init.lua) 
-- Basic setting for neovim (add numbers etc)

vim.opt.guicursor = ''
vim.opt.number = true  -- Number
vim.opt.relativenumber = true --Relativenumber

vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.autoread = true
vim.opt.expandtab = true
vim.opt.wrap = false

vim.opt.title = true
vim.opt.wildmenu = true
vim.opt.mouse = "a"

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.syntax = "on"


vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

--vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")
vim.opt.signcolumn = "auto"


vim.opt.colorcolumn = "80"
vim.opt.clipboard="unnamed,unnamedplus"

vim.diagnostic.config({ virtual_text = false })

vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
		pattern = {"*.hl", "hypr*.conf"},
		callback = function(event)
				print(string.format("starting hyprls for %s", vim.inspect(event)))
				vim.lsp.start {
						name = "hyprlang",
						-- cmd = {"hyprls"},
						root_dir = vim.fn.getcwd(),
				}
		end
})
