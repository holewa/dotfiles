-- Declare a buffer variable outside the autocommand
local bufnr

-- Function to set up the buffer
local function setup_buffer()
  if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
    bufnr = vim.api.nvim_create_buf(false, true) -- Create the buffer if it doesn't exist
    vim.cmd 'new' -- Open a vertical split
    vim.cmd 'resize 15'
    vim.api.nvim_set_current_buf(bufnr) -- Set the current buffer to the new buffer
  end
end

vim.api.nvim_create_autocmd('BufWritePost', {
  print(vim.fn.expand '%:t:r'),
  group = vim.api.nvim_create_augroup('tutorial', { clear = true }),
  pattern = '*.java,*.kt,*.groovy,*.groovy,*.kts,*.gradle',
  callback = function()
    setup_buffer()
    vim.api.nvim_buf_set_lines(bufnr, 0, 100000, false, {})
    -- vim.fn.jobstart({ "javac", vim.fn.expand("%:t:r") }, {
    -- vim.fn.jobstart({ "sh", "-c", "java ProblemC.java < input.txt" }, {
    vim.fn.jobstart({ 'sh', '-c', 'javac *.java && java ProblemC < input.txt' }, {
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
  end,
})
