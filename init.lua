require 'config.globals'
require 'config.options'
require 'config.autocommands'
require 'config.lazy'

require('lazy').setup({
  require 'plugins',
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- Filetype detection for .fs and .vs files
vim.cmd [[
  autocmd BufRead,BufNewFile *.fs set filetype=glsl
  autocmd BufRead,BufNewFile *.vs set filetype=glsl
  colorscheme "default"
]]

local project_config = vim.fn.getcwd() .. '.project.lua'
if vim.fn.filereadable(project_config) == 1 then
  dofile(project_config)
end

vim.cmd [[colorscheme lackluster-mint]]
require 'config.mappings'

if vim.fn.has 'win32' == 1 or vim.fn.has 'win64' == 1 then
  require 'config.windows'
end
