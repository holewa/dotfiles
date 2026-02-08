-- Remove trailing CR characters when pasting Windows text
vim.api.nvim_create_autocmd({"TextChanged", "TextChangedI"}, {
  pattern = "*",
  callback = function()
    local buf = 0
    local changed = false

    -- get all lines
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

    -- check and clean lines
    for i, line in ipairs(lines) do
      if line:find("\r") then
        lines[i] = line:gsub("\r", "")
        changed = true
      end
    end

    if changed then
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
      vim.bo.fileformat = "unix"
      -- optional notification; can be commented out for silent
      -- vim.notify("Cleaned Windows CR characters", vim.log.levels.INFO)
    end
  end,
})
