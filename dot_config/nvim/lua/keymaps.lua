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
vim.keymap.set('n', '<leader>F', vim.lsp.buf.format)

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
-- vim.keymap.set('n', '<leader>e', ':Neotree toggle show<CR>', { silent = false })
-- vim.keymap.set('n', '<leader>e', ':Neotree toggle reveal focus<CR>')

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
vim.keymap.set('n', '<Leader>gr.', ': %!dos2unix<CR>')

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', ':noh<CR><CR>')

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Vimwiki in note window
-- local spawn_note_window = require 'custom.plugins.spawn-note-window'
-- vim.keymap.set('n', '<leader>wl', function()
--   spawn_note_window()
-- end, { desc = 'Spawn Note Window' })

--Go back/close current window
vim.keymap.set('n', '<C-q>', ':q<CR>')

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


vim.api.nvim_set_keymap('n', '<C-w>r', '<C-w>v', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-w>b', '<C-w>s', { noremap = true, silent = true })

--rest console
vim.keymap.set('n', '<leader>xr', ':call VrcQuery()<CR>')
vim.g.vrc_horizontal_split = true

-- next/prev lsp error
vim.keymap.set('n', '<C-n>', function()
  vim.diagnostic.goto_next { float = false }
end)

-- vim.keymap.set('n', '<C-p>', function()
--   vim.diagnostic.go_to_prev { float = false }
-- end)

-- prevent esc to jump down one row
vim.api.nvim_set_keymap('n', '<Esc>', ':noh<CR>', { noremap = true, silent = true })


vim.keymap.set('n', '<C-i>', '<C-^>', { noremap = true, silent = true })

-- vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')
vim.keymap.set("n", "-", function()
  require("oil").toggle_float()
end, { desc = "Toggle Oil Float" })

local function dos2unix_function()
  -- Save search register, cursor position
  local save_search = vim.fn.getreg('/')
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local col = vim.api.nvim_win_get_cursor(0)[2]

  -- Try block equivalent
  local ok, err = pcall(function()
    vim.opt.fileformat = 'unix'    -- set ff=unix
    vim.cmd('write!')              -- save file forcibly
    -- You can also add substitution here if needed
    -- vim.cmd([[%s/\r$//e]])
  end)

  if not ok then
    print("Sorry, the file is not saved: " .. err)
  end

  -- Restore search register and cursor position
  vim.fn.setreg('/', save_search)
  vim.api.nvim_win_set_cursor(0, {line, col})
end

vim.keymap.set('n', 'p', function()
  -- Delete without affecting registers, then paste
  vim.cmd('normal! p')
  -- Run dos2unix function to fix line endings & save without jumps
  dos2unix_function()
end, { noremap = true, silent = true })
