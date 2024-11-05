return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
		require('telescope').setup({
                        layout_config = {
                                vertical = {
                                        width = 0.5,
                                        hight = 0.2,
                                }
                        },
                })

		local builtin = require('telescope.builtin')

		vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
                vim.keymap.set('n', '<leader>gg', builtin.grep_string, {})
                vim.keymap.set('n', '<leader>pg', builtin.live_grep, { desc = 'Telescope live grep' })
                vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = 'Telescope buffers' })




		vim.keymap.set('n', '<leader>ps', function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
		vim.keymap.set('n', '<leader>sh', builtin.help_tags, {desc = '[S]earch [H]elp'})
		-- Search for Neovim config file
		vim.keymap.set('n', '<leader>sn', function()
			builtin.find_files ({ cwd = vim.fn.stdpath 'config' })
                end, {desc = '[S]earch [N]eovim files'})
	end
}
