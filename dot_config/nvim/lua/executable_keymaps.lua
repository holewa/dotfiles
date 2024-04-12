vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

--LspInfo
vim.keymap.set("n", "<C-i>", ":LspInfo<CR>")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Copy from vim to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Paste from clipboard
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

--unbinding cuz ov vim navigation between windows
--vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
--vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

--TODO: Check this out! 
vim.keymap.set("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "[R]eplace [w]ord" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<C-n>", ":Neotree toggle reveal<CR>")

--harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-b>", function()
  ui.nav_next()
end)
vim.keymap.set("n", "<C-t>", function()
  ui.nav_file(2)
end)
vim.keymap.set("n", "<C-s>", function()
  ui.nav_file(4)
end)

--toggle auto-save
vim.api.nvim_set_keymap("n", "<C-s>", ":ASToggle<CR>", {})

--ChatGPT
vim.keymap.set("n", "<leader>cha", ":ChatGPT<CR>", { desc = "[A]sk ChatGPT" })
vim.keymap.set("n", "<leader>chr", ":ChatGPTRun ", { desc = "[R]un tasks" })
vim.keymap.set("n", "<leader>chf", ":ChatGPTRun fix_bugs", { desc = "[F]ix bugs" })
vim.keymap.set("n", "<leader>cht", ":ChatGPTRun add_tests", { desc = "[A]dd tests" })

