local quoteGenerator = require 'plugins.random-quote-generator'

local searchNotes = function()
  require('telescope.builtin').find_files { cwd = '~/vimwiki/' }
end

local searchInNotes = function()
  require('telescope.builtin').live_grep { cwd = '~/vimwiki/' }
end

-- Function to display a random quote in the footer
local getRandomQuote = function()
  local randomQuote = quoteGenerator.fetchRandomQuote()
  local randomQuoteContentAndAuthor = { content = randomQuote.content, author = randomQuote.author }
  return randomQuoteContentAndAuthor
end

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
            icon = ' ',
            desc = 'Toggle transparency',
            key = 't',
            action = ': TransparentToggle',
          },
          {
            desc = '󰊳 Update',
            group = '@property',
            action = 'Lazy update',
            key = 'u',
          },
          {
            desc = 'Inspirational quote goes here',
            desc_hl = 'String',
          },
        },
      },
    }
  end,
}
