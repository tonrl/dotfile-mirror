require("schlau-nvim.set")
require("schlau-nvim.remap")
require("schlau-nvim.lazy-init")

vim.cmd.colorscheme("tokyonight")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })




--vim.api.nvim_create_autocmd("FileType", {
--        pattern = {"markdown", "rust" },
--        callback = function()
--                vim.cmd.colorscheme("rose-pine")
--                vim.cmd('highlight Normal guibg=NONE ctermbg=NONE')
--        end,
--})
--vim.api.nvim_create_autocmd("BufLeave", {
--        pattern = { "*.md", "*.rs" },
--        callback = function()
--                vim.cmd('colorscheme rosepine')
--        end,
--})
