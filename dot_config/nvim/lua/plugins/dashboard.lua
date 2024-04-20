local quoteGenerator = require 'plugins.random-quote-generator'

local findVimWikis = function()
  require('telescope.builtin').find_files { cwd = '~/vimwiki/' }
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
        -- header = require 'custom-headers.custom-header',
        header = require 'custom-headers.garfield-header',
        center = {
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Find File           ',
            desc_hl = 'String',
            key = 'f',
            keymap = 'SPC f f',
            key_hl = 'Number',
            key_format = ' %s', -- remove default surrounding `[]`
            action = 'Telescope find_files',
          },
          {
            icon = ' ',
            desc = 'Find Dotfiles',
            key = 'd',
            keymap = 'SPC f d',
            key_format = ' %s', -- remove default surrounding `[]`
            action = 'lua print(3)',
          },
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Find Notes           ',
            desc_hl = 'String',
            key = 'n',
            keymap = 'SPC f f',
            key_hl = 'Number',
            key_format = ' %s', -- remove default surrounding `[]`
            action = findVimWikis,
          },
        },
        footer = {
          getRandomQuote().content,
          '- ' .. getRandomQuote().author,
        },
      },
    }
  end,
}
