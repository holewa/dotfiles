return {
  cmd = { 'ngserver', '--stdio', '--tsProbeLocations', '.', '--ngProbeLocations', '.' },
  root_dir = require('lspconfig.util').root_pattern('angular.json', 'project.json'),
  filetypes = { 'typescript', 'html', 'typescriptreact', 'typescript.tsx' },
  on_new_config = function(new_config, _)
    -- Force angularls to use the local typescript version (instead of a possibly broken global one)
    new_config.cmd = {
      'ngserver',
      '--stdio',
      '--tsProbeLocations',
      './node_modules',
      '--ngProbeLocations',
      './node_modules',
    }
  end,
}
