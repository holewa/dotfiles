return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup {
      git_status = {
        symbols = {
          -- Change type
          added = '✚',
          deleted = '✖',
          modified = '',
          renamed = '󰁕',
          -- Status type
          untracked = '',
          ignored = '',
          unstaged = '󰄱',
          staged = '',
          conflict = '',
        },
      },
      callback = function()
        vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE', ctermbg = 'NONE' })
        vim.api.nvim_set_hl(0, 'NeoTreeNormal', { bg = 'NONE', ctermbg = 'NONE' })
        vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', { bg = 'NONE', ctermbg = 'NONE' })
        -- etc...
      end,
    }
  end,
}
