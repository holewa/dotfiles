-- JDTLS (Java LSP) configuration
local jdtls = require('jdtls')
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.env.HOME .. '/jdtls-workspace/' .. project_name
local lombok_jar = '/home/hoaje/.local/share/nvim/mason/share/jdtls/lombok.jar'
local java17_path = '/home/hoaje/.sdkman/candidates/java/17.0.12-zulu/'

-- Needed for debugging
local bundles = {
  vim.fn.glob(vim.env.HOME .. '/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar'),
}

-- Needed for running/debugging unit tests
vim.list_extend(bundles,
  vim.split(vim.fn.glob(vim.env.HOME .. "/.local/share/nvim/mason/share/java-test/*.jar", 1), "\n"))

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx4g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. lombok_jar,

    -- Eclipse jdtls location
    '-jar', vim.env.HOME .. '/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar',
    '-configuration', vim.env.HOME .. '/.local/share/nvim/mason/packages/jdtls/config_linux',
    '-data', workspace_dir
  },

  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'pom.xml', 'build.gradle' }),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  settings = {
    java = {
      home = java17_path,
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        -- The runtime name parameters need to match specific Java execution environments.  See https://github.com/tamago324/nlsp-settings.nvim/blob/2a52e793d4f293c0e1d61ee5794e3ff62bfbbb5d/schemas/_generated/jdtls.json#L317-L334
        runtimes = {
          {
            name = "JavaSE-11",
            path = vim.env.HOME .. '/.sdkman/candidates/java/11.0.23-amzn/',
          },
          {
            name = "JavaSE-17",
            path = java17_path,
          },
          -- {
          --   name = "JavaSE-19",
          --   path = vim.env.HOME .. '/.sdkman/candidates/java/current/',
          -- }
        }
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      signatureHelp = { enabled = true },
      format = {
        enabled = true,
        -- Formatting works by default, but you can refer to a specific file/URL if you choose
        settings = {
          url = "https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
    },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
      importOrder = {
        "java",
        "javax",
        "com",
        "org"
      },
    },
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  },
  -- Needed for auto-completion with method signatures and placeholders
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  flags = {
    allow_incremental_sync = true,
  },
  init_options = {
    -- References the bundles defined above to support Debugging and Unit Testing
    bundles = bundles
  },
}

-- Needed for debugging
config['on_attach'] = function(client, bufnr)
  jdtls.setup_dap({ hotcodereplace = 'auto' })
  require('jdtls.dap').setup_dap_main_class_configs()
end

-- This starts a new client & server, or attaches to an existing client & server based on the `root_dir`.
jdtls.start_or_attach(config)
