vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('v', 'p', '"_dP')
vim.keymap.set('n', '<C-d', '<C-d>zz')
vim.keymap.set('n', '<C-u', '<C-u>zz')
vim.keymap.set('n', 'G', 'Gzz')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- greatest remap ever
vim.keymap.set('x', '<leader>p', [["_dP]])

-- Copy from vim to clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

-- Paste from clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>p', [["+p]])
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])

-- This is going to get me cancelled
vim.keymap.set('i', '<C-c>', '<Esc>')

vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', '<C-f>', vim.lsp.buf.format)

vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

vim.keymap.set('n', '<leader>rw', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[R]eplace [w]ord' })

--source the file
vim.keymap.set('n', '<leader>xx', ':source %<CR>', { silent = true })

-- Ensure cursor stays on the same line when pressing Esc in Normal mode
vim.api.nvim_set_keymap('n', '<Esc>', 'm`<Esc>`', { noremap = true, silent = true })
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
vim.keymap.set('n', '<Esc>', ':noh<CR><CR>')

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

-- Vimwiki in note window
local spawn_note_window = require 'custom.spawn-note-window'
vim.keymap.set('n', '<leader>wl', function()
  spawn_note_window()
end, { desc = 'Spawn Note Window' })

--Go back/close current window
vim.keymap.set('n', '<C-q>', ':q<CR>')

--Toggle transparent background
vim.keymap.set('n', '<C-t>', ':silent! TransparentToggle<CR>')

local ToggleTransparency = function()
  print 'heej'
  vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE', ctermbg = 'NONE' })
  vim.api.nvim_set_hl(0, 'NeoTreeNormal', { bg = 'NONE', ctermbg = 'NONE' })
  vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', { bg = 'NONE', ctermbg = 'NONE' })
  -- etc...
end

-- Toggle Git blame using vim fugitive
local ToggleBlame = function()
  if vim.bo.filetype == 'fugitiveblame' then
    vim.cmd 'close'
  else
    vim.cmd 'G blame'
  end
end

vim.keymap.set('n', '<leader>gb', function()
  ToggleBlame()
end, { desc = 'Git [b]lame' })

-- yank related keybinds
vim.keymap.set('n', '<leader>ya', 'ggVGy', { desc = '[y]ank [a]ll' })
--  have the cursor jump back after yank
vim.keymap.set('v', 'y', 'ygv<ESC>', { desc = '[y]ank [a]ll' })
--Replace word with last yanked word
vim.keymap.set('n', '<leader>ry', '"_viwp', { desc = '[R]eplace with [y]anked word' })
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

--Flutter keybinds
vim.keymap.set('n', '<leader>fr', ':FlutterRun<CR>', { desc = '[F]lutter [R]un' })
vim.keymap.set('n', '<leader>fq', ':FlutterQuit<CR>', { desc = '[F]lutter [Q]uit' })
vim.keymap.set('n', '<leader>fb', ':FlutterRestart<CR>', { desc = '[F]lutter Re[b]oot' })
vim.keymap.set('n', '<leader>flr', ':FlutterLspRestart<CR>', { desc = '[F]lutter [L]sp [R]estart' })

vim.api.nvim_set_keymap('n', '<C-w>r', '<C-w>v', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-w>b', '<C-w>s', { noremap = true, silent = true })

--rest console
vim.keymap.set('n', '<leader>xr', ':call VrcQuery()<CR>')

