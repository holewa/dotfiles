return {
  'vimwiki/vimwiki',
  init = function()
    vim.g.vimwiki_list = {
      {
        path = '~/vimwiki',
        syntax = 'default',
        ext = '.wiki',
      },
    }
  end,
  config = function()
    -- Setting highlight colors for Vimwiki headers
    vim.cmd [[
    hi VimwikiHeader1 guifg=#E06C75
    hi VimwikiHeader2 guifg=#98C379
    hi VimwikiHeader3 guifg=#61AFEF
    hi VimwikiHeader4 guifg=#C678DD
    hi VimwikiHeader5 guifg=#56B6C2
    hi VimwikiHeader6 guifg=#E5C07B 
    ]]
  end,
}
