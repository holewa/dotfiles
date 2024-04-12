-- Define the function to create the input window
local function create_input_window()
    -- Define the content of the header
    local header_content = "'Pen and paper are formidable warriors.' - Martin Luther"
    
    -- Calculate the dimensions and position of the input window
    local width = 50  -- Adjust width as needed
    local height = 10   -- Adjust height as needed
    local row = (vim.api.nvim_get_option("lines") - height) / 2
    local col = (vim.api.nvim_get_option("columns") - width) / 2

    -- Create a new buffer for the input window
    local buf = vim.api.nvim_create_buf(false, true)

    -- Set up the input window options
    local opts = {
        style = "minimal",
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        focusable = true,
        border = "single"
    }

    -- Create the window
    local win = vim.api.nvim_open_win(buf, true, opts)

    -- Set up the header content
    local header_lines = {header_content}

    -- Set up the input field
    local input_lines = {""}

    -- Set the content of the buffer
    vim.api.nvim_buf_set_lines(buf, 0, 1, false, header_lines)
    vim.api.nvim_buf_set_lines(buf, 1, -1, false, input_lines)

    -- Set up autocommands to save and close the buffer
    vim.api.nvim_command("autocmd BufWriteCmd <buffer> lua save_input()")
    vim.api.nvim_command("autocmd BufWriteCmd <buffer> :q")
end

-- Define the function to save the input
local function save_input()
    local buf = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(buf, 1, -1, false)
    local content = table.concat(lines, "\n")
    local filename = string.sub(content, 1, 15) .. ".md"
    local file = io.open(vim.fn.expand("~/Documents/neovim_input/" .. filename), "w")
    if file then
        file:write(content)
        file:close()
    else
        print("Error: Unable to save input.")
    end
end

-- Expose the create_input_window function to be called from Neovim
return {
    create_input_window = create_input_window
}
