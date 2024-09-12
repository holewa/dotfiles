local jdtls = require 'jdtls'
local home = os.getenv 'HOME'

local jdtls_dir = vim.fn.stdpath 'data' .. '/mason/packages/jdtls'
local config_dir = jdtls_dir .. '/config_linux'
local plugins_dir = jdtls_dir .. '/plugins'
local lombok_jar = '/home/hoaje/.local/share/nvim/mason/packages/jdtls/lombok.jar'

local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
local root_dir = require('jdtls.setup').find_root(root_markers)
if root_dir == nil then
  return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath 'data' .. '/site/java/workspace-root/' .. project_name

local status, jdtls = pcall(require, 'jdtls')
if not status then
  return
end
local extendedClientCapabilities = jdtls.extendedClientCapabilities

-- Main config
local config = {
 cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. home .. '/.local/share/nvim/mason/packages/jdtls/lombok.jar',
    '-jar',
    vim.fn.glob(home .. '/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher.gtk.linux.aarch64_1.2.1100.v20240722-2106.jar'),
    '-configuration',
    home .. '/.local/share/nvim/mason/packages/jdtls/config_linux',
    '-data',
    workspace_dir,
  },
  root_dir = root_dir,

  settings = {
    java = {
      home = home .. '/.sdkman/candidates/java/current/',
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = 'interactive',
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
      format = {
        enabled = true,
        settings = {
          url = vim.fn.stdpath 'config' .. '/lang-servers/intellij-java-google-style.xml',
          profile = 'GoogleStyle',
        },
      },
    },
  },

  signatureHelp = { enabled = true },

  codeGeneration = {
    toString = {
      template = '${object.className} {${member.name()}=${member.value}}, ${otherMembers}',
    },
    useBlocks = true,
  },

  flags = {
    allow_incremental_sync = true,
  },
  init_options = {
    bundles = {
      lombok_jar, -- Include Lombok path here
    },
  },
}

config['on_attach'] = function(client, bufnr)
  require('jdtls').setup_dap { hotcodereplace = 'auto' }
  -- require('keymaps').map_java_keys(bufnr)
end

jdtls.start_or_attach(config)
