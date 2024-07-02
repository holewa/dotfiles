-- In your vimwiki_progress.lua

local api = vim.api

-- Function to calculate progress of checkbox items in VimWiki
local function vimwiki_progress()
    local total_items = 0
    local checked_items = 0

    -- Iterate over each line in the current buffer
    for lnum = 1, api.nvim_buf_line_count(0) do
        local line = api.nvim_buf_get_lines(0, lnum - 1, lnum, false)[1]
        -- Check if it's a checkbox list item
        if line:match('^%s*%[%s*%]') then
            total_items = total_items + 1
            -- Check if it's checked
            if line:match('^%s*%[x%]') then
                checked_items = checked_items + 1
            end
        end
    end

    -- Calculate progress percentage
    local progress = 0
    if total_items > 0 then
        progress = math.floor((checked_items * 100) / total_items)
    end

    -- Display progress bar
    local progress_bar = string.format("Progress: [%s] %d%%", string.rep('#', progress), progress)
    api.nvim_command('echo "' .. progress_bar .. '"')
end

-- Auto update progress bar on VimWiki write
api.nvim_command('autocmd BufWritePost *.wiki lua vimwiki_progress()')

-- Command to manually update progress bar
api.nvim_command('command! VimwikiProgressUpdate lua vimwiki_progress()')
