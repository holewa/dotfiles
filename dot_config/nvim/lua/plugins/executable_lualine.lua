return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require('lualine').setup {
      options = {
        fmt = string.lower,
        theme = 'catppuccin', --dracula
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {},
        lualine_c = {
          {
            'filename',
            path = 1}
        },
        lualine_x = {'branch', 'diff', 'diagnostics'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      }
    }
  end
}

