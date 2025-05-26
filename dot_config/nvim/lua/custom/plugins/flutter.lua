return {
	'akinsho/flutter-tools.nvim',
	lazy = false,
	dependencies = {
		'nvim-lua/plenary.nvim',
		'stevearc/dressing.nvim', -- optional for vim.ui.select
	},
	config = function()
		require('flutter-tools').setup {
			--Flutter keybinds
			-- vim.keymap.set('n', '<leader>Fr', ':FlutterRun<CR>', { desc = '[F]lutter [R]un' }),
			-- vim.keymap.set('n', '<leader>Fq', ':FlutterQuit<CR>', { desc = '[F]lutter [Q]uit' }),
			-- vim.keymap.set('n', '<leader>Fb', ':FlutterRestart<CR>', { desc = '[F]lutter Re[b]oot' }),
			-- vim.keymap.set('n', '<leader>Flr', ':FlutterLspRestart<CR>', { desc = '[F]lutter [L]sp [R]estart' })

		}
	end,
}
