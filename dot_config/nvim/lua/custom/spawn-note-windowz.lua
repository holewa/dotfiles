local function spawn_note_window()
  local path = '~/vimwiki/daily-notes/'
  local index_file = path .. 'index.wiki'
  local daily_notes_file = path .. 'daily-notes.wiki'
  local note_file = path .. 'note-' .. os.date 'note-%d-%m-%y' .. '.wiki' -- Naming the note file based on the date

  -- Empty buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Get current UI dimensions
  local ui = vim.api.nvim_list_uis()[1]
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

  -- Create or open the note file
  if vim.fn.filereadable(vim.fn.expand(note_file)) == 1 then
    vim.api.nvim_command('e ' .. vim.fn.fnameescape(note_file))
  else
    vim.api.nvim_command('split ' .. vim.fn.fnameescape(note_file))
  end

  -- Set options and start editing
  local column = 80
  vim.api.nvim_command('set textwidth=' .. column)
  vim.api.nvim_command('set colorcolumn=' .. column)
  vim.api.nvim_command 'norm G2o'
  vim.api.nvim_command 'norm Gi- '
  vim.api.nvim_command 'norm zz'
  vim.api.nvim_command 'startinsert'

  -- Append a link to the daily notes file
  local link_text = os.date '%Y-%m-%d' .. ' - New note'
  local link = '[[' .. note_file .. '|' .. link_text .. ']]'
  vim.fn.append(daily_notes_file, link)

  -- Update the index file to include a link to daily notes if it doesn't exist
  local daily_notes_link = '[[' .. daily_notes_file .. '|Daily Notes]]'
  local index_content = vim.fn.readfile(index_file)
  local found = false
  for _, line in ipairs(index_content) do
    if line == daily_notes_link then
      found = true
      break
    end
  end
  if not found then
    vim.fn.append(index_file, daily_notes_link)
  end
end

return spawn_note_window
