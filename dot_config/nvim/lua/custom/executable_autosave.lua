-- Declare a buffer variable outside the autocommand
local bufnr

-- Function to set up the buffer
local function setup_buffer()
    if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
        bufnr = vim.api.nvim_create_buf(false, true) -- Create the buffer if it doesn't exist
        vim.cmd("vnew")                              -- Open a vertical split
        vim.cmd("vertical resize 40")
        vim.api.nvim_set_current_buf(bufnr)          -- Set the current buffer to the new buffer
    end
end



vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("tutorial", { clear = true }),
    pattern = '*.java,*.kt,*.groovy,*.groovy,*.kts,*.gradle',
    callback = function()
        setup_buffer();
        --create a new buffer
        -- bufnr = vim.api.nvim_create_buf(false, true)     -- false: not listed, true: scratch buffer
        -- vim.cmd("new")                                   -- Open a new split window
        -- vim.api.nvim_set_current_buf(bufnr)
        -- Clear existing lines in the buffer
        -- vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {})     -- Clear the buffer
        -- run gradle test
        vim.fn.jobstart({ "gradle", "test" }, {
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
})
