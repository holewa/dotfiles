vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('v', 'p', '"_dP')
vim.keymap.set('n', '<C-d', '<C-d>zz')
vim.keymap.set('n', '<C-u', '<C-u>zz')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

--LspInfo
-- vim.keymap.set('n', '<C-i>', ':LspInfo<CR>')

-- greatest remap ever
vim.keymap.set('x', '<leader>p', [["_dP]])

-- Copy from vim to clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

-- Paste from clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>p', [["+p]])
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])

--Replace word with last yanked word
vim.keymap.set('n', 'cr', 'viwp')

-- This is going to get me cancelled
vim.keymap.set('i', '<C-c>', '<Esc>')

vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)

--unbinding cuz ov vim navigation between windows
--vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
--vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

--TODO: Check this out!
vim.keymap.set('n', '<leader>rw', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[R]eplace [w]ord' })
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

--toggle auto-save
--vim.api.nvim_set_keymap('n', '<C-s>', ':ASToggle<CR>', {})
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', {})

--ChatGPT
vim.keymap.set('n', '<leader>cha', ':ChatGPT<CR>', { desc = '[A]sk ChatGPT' })
vim.keymap.set('n', '<leader>chr', ':ChatGPTRun ', { desc = '[R]un tasks' })
vim.keymap.set('n', '<leader>chf', ':ChatGPTRun fix_bugs', { desc = '[F]ix bugs' })
vim.keymap.set('n', '<leader>cht', ':ChatGPTRun add_tests', { desc = '[A]dd tests' })

--Neotree
vim.keymap.set('n', '<leader>N', ':Neotree toggle show<CR>', { silent = false })
vim.keymap.set('n', '<leader>n', ':Neotree toggle reveal focus<CR>')

--centering screen when jumping
vim.keymap.set('v', 'p', '"_dP')
vim.keymap.set('n', '<C-d', '<C-d>zz')
vim.keymap.set('n', '<C-u', '<C-u>zz')

-- Paste in terminal
vim.keymap.set('t', '<c-r>', function()
  local next_char_code = vim.fn.getchar()
  local next_char = vim.fn.nr2char(next_char_code)
  return '<C-\\><C-N>"' .. next_char .. 'pi'
end, { expr = true })

--consolelog
vim.keymap.set('n', '<leader>icl', "iconsole.log('')<ESC>hi")
vim.keymap.set('n', '<leader>icn', "oconsole.log('')<ESC>hi")

--format windows format to unix
vim.keymap.set('n', '<Leader>.', ': %!dos2unix<CR>')

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.keymap.set('n', '<leader>theme', ':colorscheme duskfox<cr>')
