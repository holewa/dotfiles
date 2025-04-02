
local searchInNotes = function()
  require('telescope.builtin').live_grep { cwd = '~/vimwiki/' }
end

local quote = 'inspirationl_quote_goes_here'
-- local quoteGenerator = require 'plugins.random-quote-generator'

return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      theme = 'doom',
      config = {
        week_header = {
          enable = true, --boolean use a week header
          -- append = require 'custom.headers.custom-header',
        },
        -- header = require 'custom.headers.custom-header',
        -- header = require 'custom.headers.garfield-header',
        center = {
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Find File           ',
            key = 'f',
            action = 'Telescope find_files',
          },
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Search in Files          ',
            key = 'g',
            action = 'Telescope live_grep',
          },
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Search Vimwiki           ',
            key = 'w',
            action = searchInNotes,
          },
          {
            desc = '󰊳 Update',
            group = '@property',
            action = 'Lazy update',
            key = 'u',
          },
          {
            desc = quote,
            desc_hl = 'String',
          },
        },
      },
    }
  end,
}
