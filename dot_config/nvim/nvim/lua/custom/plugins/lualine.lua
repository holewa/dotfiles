return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'folke/trouble.nvim' },
  opts = function()
    local trouble = require 'trouble'
    local symbols = trouble.statusline {
      mode = 'lsp_document_symbols',
      groups = {},
      title = false,
      filter = { range = true },
      format = '{kind_icon}{symbol.name:Normal}',
      hl_group = 'lualine_c_normal',
    }
    return {
      options = {
        fmt = string.lower,
        theme = 'catppuccin',
        icons_enabled = true,
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {},
        lualine_c = {
          {
            'filename',
            path = 1,
          },
          {
            symbols.get,
            cond = symbols.has,
          },
        },
        lualine_x = {},
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    }
  end,
}
