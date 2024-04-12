  return {
    -- Set lualine as statusline
    "nvim-lualine/lualine.nvim",
    -- See `:help lualine.txt`
    config = function()
      require('lualine').setup {
        options = {
          fmt = string.lower,
          theme = 'auto', --dracula
          icons_enabled = false,
          component_separators = "|",
          section_separators = "",
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {},
          lualine_c = {
            {
              'filename',
              path = 1 }
          },
          lualine_x = {
            'branch',
            --'diff',
            --'diagnostics'
          },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        }
      }
    end,
    opts = {
      options = {
      },
    },
  }
