return {
  'vimwiki/vimwiki',
  init = function()
    vim.g.vimwiki_list = {
      {
        path = '~/vimwiki',
        syntax = 'default',
        ext = '.wiki',
        vimwiki_folding = 'list'
      },
    }
  end,
  config = function()
    -- Function to handle custom folding
    function _G.VimwikiFoldExpr()
      local line = vim.fn.getline(vim.v.lnum)
      if line:match("^%s*[-*]\\s") then
        return ">" .. (vim.fn.indent(vim.v.lnum) / vim.o.shiftwidth + 1)
      end
      return "="
    end

    -- Set up autocommands to use the custom fold expression for Vimwiki
    vim.cmd [[
      augroup VimwikiFolding
      autocmd!
      autocmd FileType vimwiki setlocal foldmethod=expr
      autocmd FileType vimwiki setlocal foldexpr=VimwikiFoldExpr()
      augroup END
      ]]

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
