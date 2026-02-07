local bufnr

-- CHANGE THIS WHEN YOU WANT A DIFFERENT BUILD COMMAND:
-- local build_cmd = { 'sh', '-c', 'mvn clean install' }
-- Example later:
local build_cmd = { 'sh', '-c', 'java -jar target/demo-0.0.1-SNAPSHOT.jar ' }

local function setup_buffer()
  if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
    bufnr = vim.api.nvim_create_buf(false, true)
    vim.cmd 'new'
    vim.cmd 'resize 15'
    vim.api.nvim_set_current_buf(bufnr)
  end
end

local function run_build(cmd)
  setup_buffer()
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {})

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
      end
    end,
    on_stderr = function(_, data)
      if data then
        vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
      end
    end,
  })
end

vim.api.nvim_create_autocmd('BufWritePost', {
  group = vim.api.nvim_create_augroup('autosave_build', { clear = true }),
  pattern = '*.java,*.kt,*.groovy,*.kts,*.gradle',
  callback = function()
    run_build(build_cmd)
  end,
})
