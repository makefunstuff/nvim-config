require 'config.globals'
require 'config.options'
require 'config.autocommands'
require 'config.lazy'

require('lazy').setup({
  require 'plugins',
}, {
  ui = { border = 'rounded' },
  change_detection = { notify = false },
})

require 'config.mappings'

if vim.fn.has 'win32' == 1 then
  require 'config.windows'
end

local project_config = vim.fn.getcwd() .. '/.project.lua'
if vim.fn.filereadable(project_config) == 1 then
  dofile(project_config)
end
