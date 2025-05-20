local M = {}

function M.on_attach(_, bufnr)
  -- note: remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself.
  --
  -- in this case, we create a function that lets us more easily define mappings specific
  -- for lsp related items. it sets the mode, buffer and description for us each time.
  local map = function(keys, func, desc, mode)
    mode = mode or 'n'
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'lsp: ' .. desc })
  end
	-- NOTE: Now in snacks
  -- find references for the word under your cursor.
  map('grr', require('telescope.builtin').lsp_references, '[g]oto [r]eferences')
  -- jump to the implementation of the word under your cursor.
  --  useful when your language has ways of declaring types without an actual implementation.
  map('gri', require('telescope.builtin').lsp_implementations, '[g]oto [i]mplementation')
  -- jump to the definition of the word under your cursor.
  --  this is where a variable was first declared, or where a function is defined, etc.
  --  to jump back, press <c-t>.
  --  Comment this out couse it dont allways work
  map('grd', require('telescope.builtin').lsp_definitions, '[g]oto [d]efinition')
  -- warn: this is not goto definition, this is goto declaration.
  --  for example, in c this would take you to the header.
  map('grD', vim.lsp.buf.declaration, '[g]oto [d]eclaration')
  -- fuzzy find all the symbols in your current document.
  --  symbols are things like variables, functions, types, etc.
  map('go', require('telescope.builtin').lsp_document_symbols, 'open document symbols')

  -- fuzzy find all the symbols in your current workspace.
  --  similar to document symbols, except searches over your entire project.
  map('gw', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'open workspace symbols')



  -- jump to the type of the word under your cursor.
  --  useful when you're not sure what type a variable is and you want to see
  --  the definition of its *type*, not where it was *defined*.
  map('grt', require('telescope.builtin').lsp_type_definitions, '[g]oto [t]ype definition')
end

return M
