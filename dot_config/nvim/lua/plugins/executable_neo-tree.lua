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
      filesystem = {
        filtered_items = {
          visible = false,    -- When true, they will be shown, hidden otherwise
          hide_dotfiles = false, -- Hide dotfiles like .git, .env, etc.
          hide_gitignored = false, -- Hide files ignored by git
          hide_by_name = {
            -- Add directories or files to ignore
            "node_modules",
            "target",
            "build",
            ".git",
            "dist",
            "__pycache__",
          },
          hide_by_pattern = { -- Use patterns to hide specific file types
            "*.class",
            "*.tmp",
            ".*",
          },
        },
      },
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
