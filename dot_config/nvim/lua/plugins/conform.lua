  return { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    -- keys = {
    --   {
    --     '<C-f>',
    --     function()
    --       require('conform').format { async = true, lsp_fallback = true }
    --     end,
    --     mode = '',
    --     desc = '[F]ormat buffer',
    --   },
    -- },
    opts = {
      notify_on_error = true,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true, angularls = true, javascript = true,}
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
          indent = 16,         -- Set indent size to 2 spaces
          tabsize = 16,
          continuation_indent = 16,  -- Set continuation indent size to 2 spaces
          max_line_length = 120,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
      },
    },
  }
