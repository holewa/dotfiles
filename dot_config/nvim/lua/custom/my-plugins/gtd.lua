local function move_task_to_file(header)
  local bufnr = vim.api.nvim_get_current_buf()
  local current_line_num = vim.api.nvim_win_get_cursor(0)[1] -- 1-indexed
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local current_line = lines[current_line_num]

  if not current_line or current_line == "" then
    vim.notify("Current line is empty, nothing to move.", vim.log.levels.WARN)
    return
  end

  -- Remove current line from buffer
  table.remove(lines, current_line_num)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)

  -- Compute target file path
  local current_file = vim.api.nvim_buf_get_name(bufnr)
  local dir = vim.fn.fnamemodify(current_file, ":h")
  local target_filename = string.lower(header) .. ".wiki"
  local target_path = dir .. "/" .. target_filename


  -- Open target file for append
  local f, err = io.open(target_path, "a")
  if not f then
    vim.notify("Failed to open target file: " .. err, vim.log.levels.ERROR)
    return
  end

  -- Append the line
  f:write(current_line .. "\n")
  f:close()

  vim.notify("Moved line to " .. target_filename .. " ✅", vim.log.levels.INFO)
end

return move_task_to_file
