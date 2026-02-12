  return {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      -- brief aside: **what is lsp?**
      --
      -- lsp is an initialism you've probably heard, but might not understand what it is.
      --
      -- lsp stands for language server protocol. it's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- in general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). these language servers
      -- (sometimes called lsp servers, but that's kind of like atm machine) are standalone
      -- processes that communicate with some "client" - in this case, neovim!
      --
      -- lsp provides neovim with features like:
      --  - go to definition
      --  - find references
      --  - autocompletion
      --  - symbol search
      --  - and more!
      --
      -- thus, language servers are external tools that must be installed separately from
      -- neovim. this is where `mason` and related plugins come into play.
      --
      -- if you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  this function gets run when an lsp attaches to a particular buffer.
      --    that is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('lspattach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          vim.api.nvim_create_autocmd('LspAttach', {

            group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
            callback = function(event)
              local client = vim.lsp.get_client_by_id(event.data.client_id)

              -- ✅ Only register highlight autocommands if the server supports it
              if client and client.server_capabilities.documentHighlightProvider then
                local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })

                vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                  group = highlight_augroup,
                  buffer = event.buf,
                  callback = vim.lsp.buf.document_highlight,
                })

                vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                  group = highlight_augroup,
                  buffer = event.buf,
                  callback = vim.lsp.buf.clear_references,
                })

                vim.api.nvim_create_autocmd('LspDetach', {
                  group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                  buffer = event.buf,
                  callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds {
                      group = highlight_augroup,
                      buffer = event2.buf,
                    }
                  end,
                })
              end
            end,
          })
          -- the following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- this may be unwanted, since they displace some of your code
          -- map('<leader>th', function()
          --   vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          -- end, '[t]oggle inlay [h]ints')
        end,
      })

      -- diagnostic config
      -- see :help vim.diagnostic.opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.error },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.error] = '󰅚 ',
            [vim.diagnostic.severity.warn] = '󰀪 ',
            [vim.diagnostic.severity.info] = '󰋽 ',
            [vim.diagnostic.severity.hint] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.error] = diagnostic.message,
              [vim.diagnostic.severity.warn] = diagnostic.message,
              [vim.diagnostic.severity.info] = diagnostic.message,
              [vim.diagnostic.severity.hint] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- lsp servers and clients are able to communicate to each other what features they support.
      --  by default, neovim doesn't support everything that is in the lsp specification.
      --  when you add blink.cmp, luasnip, etc. neovim now has *more* capabilities.
      --  so, we create new capabilities with blink.cmp, and then broadcast that to the servers.
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- enable the following language servers
      --  feel free to add/remove any lsps that you want here. they will automatically be installed.
      --
      --  add any additional override configuration in the following tables. available keys are:
      --  - cmd (table): override the default command used to start the server
      --  - filetypes (table): override the default list of associated filetypes for the server
      --  - capabilities (table): override fields in capabilities. can be used to disable certain lsp features.
      --  - settings (table): override the default settings passed when initializing the server.
      --        for example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. see `:help lspconfig-all` for a list of all the pre-configured lsps
        --
        -- some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- but for many setups, the lsp (`ts_ls`) will work just fine
        ts_ls = {},
        --

        lua_ls = {
          -- cmd = { ... },
          -- filetypes = { ... },
          capabilities = {},
          settings = {
            lua = {
              diagnostics = { globals = { "vim" } },
              completion = {
                callsnippet = 'replace',
              },
              workspace = {
                library = {}, -- Add your runtime paths here if needed
                maxPreload = 1000,
                preloadFileSize = 100,
                checkThirdParty = false,
              },
              telemetry = { enable = false }, -- Optional: disables telemetry
              -- you can toggle below to ignore lua_ls's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- ensure the servers and tools above are installed
      --
      -- to check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :mason
      --
      -- you can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- you can add other tools here that you want mason to install
      -- for you, so that they are available from within neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'prettier', -- prettier formatter
        'stylua', -- used to format lua code
        'angularls',
        'cssls',
        -- 'tailwindcss',
        'svelte',
        'ts_ls',
        'html',
        'bashls',
        'isort', -- python formatter
        'black', -- python formatter
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason').setup {
        ui = {
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}

            -- handle java configuration
            if server_name == 'jdtls' then
              return
            end

            -- handle agnular configuration by stopping ts_ls from attaching component.ts-files
            if server_name == 'angularls' then
              local angularls_opts = require 'custom.plugins.lsp.angularls'
              server = vim.tbl_deep_extend('force', server, angularls_opts)
            end

            if server_name == 'ts_ls' or server_name == 'html' then
              local original_on_attach = server.on_attach
              server.on_attach = function(client, bufnr)
                if disable_for_angular_templates(nil, bufnr) then
                  client.stop()
                  return
                end
                if original_on_attach then
                  original_on_attach(client, bufnr)
                end
              end
            end

            -- merge server capabilities with defaults
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  }
