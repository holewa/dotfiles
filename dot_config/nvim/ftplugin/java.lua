local home = vim.env.HOME
local mason_path = vim.fn.stdpath 'data' .. '/mason'
local launcher_jar = vim.fn.glob(mason_path .. '/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar', true, true)[1]
local java_path = home .. '/.sdkman/candidates/java'
local java21 = java_path .. '/21.0.7-zulu/bin/java'
local root_path = vim.fs.find({'.git', 'mvnw', 'gradlew'}, { upward = true })[1]

local root_dir
if root_path then
  root_dir = vim.fs.dirname(root_path)
else
  root_dir = vim.loop.cwd()
end

local workspace_folder_name = ''
if root_dir then
  workspace_folder_name = vim.fn.fnamemodify(root_dir, ':t')
else
  workspace_folder_name = 'default_workspace'
end

-- local map = function(keys, func, opt)
--   local mode = 'n'
--   vim.keymap.set(mode, keys, func, opt)
-- end

local config = {
  settings = {
    java = {
      format = {
        settings = {
          enabled = true,
          url = vim.fn.expand '~/.local/share/ecplipse/eclipse-java-google-style.xml',
          -- url = 'https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml',
          -- url = vim.fn.expand '~/.local/share/nvim/intellij-java-google-style.xml', -- optional formatter config file
          profile = 'GoogleStyle',
        },
      },
      configuration = {
        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        -- And search for `interface RuntimeOption`
        -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
        -- runtimes = {
        --   {
        --     name = 'JavaSE-17',
        --     path = java_path .. '/17.0.12-zulu',
        --   },
        -- },
      },
    },
  },
  root_dir = root_dir,
  cmd = {
    java21,
    '-javaagent:' .. mason_path .. '/packages/jdtls/lombok.jar',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-jar',
    launcher_jar,
    '-configuration',
    mason_path .. '/packages/jdtls/config_linux',
    '-data',
    vim.fn.stdpath 'cache' .. '/jdtls/' .. workspace_folder_name,
  },
}

-- local lsp_keymaps = require('custom.plugins.lsp.lps_keymaps').on_attach
-- This starts a new client & server,

-- or attaches to an existing client & s
-- require('jdtls').start_or_attach(vim.tbl_deep_extend('force', config, {
  -- on_attach = lsp_keymaps,
-- }))
--
require('jdtls').start_or_attach(config)
