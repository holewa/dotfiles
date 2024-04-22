local quoteGenerator = require 'plugins.random-quote-generator'

local searchNotes = function()
  require('telescope.builtin').find_files { cwd = '~/vimwiki/' }
end

local searchInNotes = function()
  require('telescope.builtin').live_grep { cwd = '~/vimwiki/' }
end

local open_project_picker = function() end

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
        -- week_header = {
        --   enable = true, --boolean use a week header
        -- },
        -- header = require 'custom.headers.custom-header',
        header = require 'custom.headers.garfield-header',
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
            desc = 'Search in Files using [g]rep          ',
            key = 'g',
            action = 'Telescope live_grep',
          },
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Open Project          ',
            key = 'o',
            action = open_project_picker,
          },
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Open Vimwiki           ',
            key = 'w',
            action = 'VimwikiIndex',
          },
          -- {
          --   icon = ' ',
          --   icon_hl = 'Title',
          --   desc = 'Search in Notes           ',
          --   key = 'n',
          --   action = searchInNotes,
          -- },
          -- {
          --   icon = ' ',
          --   desc = 'Manage Dotfiles',
          --   key = 'd',
          --   key_hl = 'Number',
          --   action = 'lua print("Not implemented yet")',
          -- },
          {
            icon = ' ',
            desc = 'Toggle header/ransparency',
            key = 't',
            action = ': TransparentToggle',
          },
          {
            desc = '󰊳 Update',
            desc_hl = 'String',
            group = '@property',
            action = 'Lazy update',
            key = 'u',
          },
        },

        footer = {
          ' ',
          ' ',
          ' ',
          ' ',
          ' ',
          getRandomQuote().content,
          '- ' .. getRandomQuote().author,
        },
      },
    }
  end,
}
