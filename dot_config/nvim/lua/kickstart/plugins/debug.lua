-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
    -- NOTE: Yes, you can install new plugins here!
    'mfussenegger/nvim-dap',
    -- NOTE: And you can specify dependencies as well
    dependencies = {
        -- Creates a beautiful debugger UI
        'rcarriga/nvim-dap-ui',

        -- Required dependency for nvim-dap-ui
        'nvim-neotest/nvim-nio',

        -- Installs the debug adapters for you
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',

        -- Add your own debuggers here
        -- 'leoluz/nvim-dap-go',
        "theHamsta/nvim-dap-virtual-text", -- adding this line gives error
    },
    keys = {
        { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
        { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },

        { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },

        { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
        { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
        { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
        { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
        { "<leader>dj", function() require("dap").down() end, desc = "Down" },
        { "<leader>dk", function() require("dap").up() end, desc = "Up" },
        { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
        { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
        { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
        { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
        { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
        { "<leader>ds", function() require("dap").session() end, desc = "Session" },
        { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
        { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
        {
            '<leader>du',
            function()
                require('dapui').toggle()
            end,
            desc = 'Debug: See last session result.',
        },
    },

    -- Eval var under cursor
    vim.keymap.set("n", "<space>de", function()
        require("dapui").eval(nil, { enter = true })
    end),

    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'

        require('mason-nvim-dap').setup {
            -- Makes a best effort to setup the various debuggers with
            -- reasonable debug configurations
            automatic_installation = true,

            -- You can provide additional configuration to the handlers,
            -- see mason-nvim-dap README for more information
            handlers = {},

            -- You'll need to check that you have the required things installed
            -- online, please don't ask me how to install them :)
            ensure_installed = {
                -- Update this to ensure that you have the debuggers for the langs you want
                'delve',
            },
        }

        dapui.setup({
            expand_lines = true,
            controls = { enabled = false },
            floating = { border = "rounded" },

            render = {
                max_type_length = 60,
                max_value_lines = 200,
            },

            layouts = {
                {
                    elements = {
                        { id = "scopes",  size = 0.6 }, -- variables
                        { id = "console", size = 0.4 }, -- program output / stacktrace
                    },
                    size = 15,
                    position = "bottom",
                },
            },
        })
        vim.keymap.set("n", "<leader>d", "<nop>")

        require("nvim-dap-virtual-text").setup {
            highlight_changed_variables = false,
            all_frames = true,
        }
        vim.api.nvim_set_hl(0, "DapBreakpoint", {
            -- bg = "green", -- pick a subtle color
            nocombine = true,
        })
        vim.fn.sign_define('DapBreakpoint',
            {
                text = '⚪',
                texthl = 'DapBreakpointSymbol',
                linehl = 'DapBreakpoint',
                numhl = 'DapBreakpoint'
            })

        vim.fn.sign_define('DapStopped',
            {
                text = '🔴',
                texthl = 'yellow',
                linehl = 'DapBreakpoint',
                numhl = 'DapBreakpoint'
            })
        vim.fn.sign_define('DapBreakpointRejected',
            {
                text = '⭕',
                texthl = 'DapStoppedSymbol',
                linehl = 'DapBreakpoint',
                numhl = 'DapBreakpoint'
            })

        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

    end,
}
