local function spawn_note_window()
  local path = '~/vimwiki/daily-notes/'
  local file_name = os.date(path .. 'note-%d-%m-%y.wiki') -- Format the date into the filename
  -- Empty buffer
  local buf = vim.api.nvim_create_buf(false, true)
  -- Get current UI
  local ui = vim.api.nvim_list_uis()[1]
  -- Dimensions
  local width = math.floor(ui.width / 2)
  local height = math.floor(ui.height / 2)
  -- Options for new window
  local opts = {
    relative = 'editor',
    width = width,
    height = height,
    col = math.floor((ui.width - width) / 2),
    row = math.floor((ui.height - height) / 2),
    anchor = 'NW',
    style = 'minimal',
    border = 'single',
  }
  -- Spawn window
  local win = vim.api.nvim_open_win(buf, true, opts)
  -- Open or create the note for the day
  if vim.fn.filereadable(vim.fn.expand(file_name)) == 1 then
    vim.cmd('e ' .. vim.fn.fnameescape(file_name))
    local column = 80
    vim.cmd('set textwidth=' .. column)
    vim.cmd('set colorcolumn=' .. column)
    vim.cmd 'norm Go'
    vim.cmd 'norm zz'
    vim.cmd 'startinsert'
  else
    vim.cmd('e ' .. vim.fn.fnameescape(file_name))
    local column = 80
    vim.cmd('set textwidth=' .. column)
    vim.cmd('set colorcolumn=' .. column)
    vim.cmd('norm Gi= Notes for ' .. os.date '%d-%m-%y' .. ' =')
    vim.cmd 'norm G2o'
    vim.cmd 'norm Gi-'
    vim.cmd 'norm zz'
    vim.cmd 'startinsert'
  end
end

return spawn_note_window
