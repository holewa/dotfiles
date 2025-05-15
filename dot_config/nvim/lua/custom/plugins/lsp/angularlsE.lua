local M = {}

M.config = {
  cmd = { 'ngserver', '--stdio' },
  filetypes = { 'typescript', 'html' },
  root_dir = require('lspconfig').util.root_pattern('angular.json', 'tsconfig.json'),
  settings = {
    angular = {
      template = {
        autoCompletion = true,
        format = true,
      },
    },
  },
}

return M
