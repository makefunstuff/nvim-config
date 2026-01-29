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

require('focus').setup()

-- -- Filetype detection for .fs and .vs files
vim.cmd [[
  autocmd BufRead,BufNewFile *.fs set filetype=glsl
  autocmd BufRead,BufNewFile *.vs set filetype=glsl
  autocmd BufRead,BufNewFile *.hlsl set filetype=hlsl
  autocmd BufRead,BufNewFile *.fx set filetype=hlsl
]]

vim.cmd 'colorscheme ayu'

local project_config = vim.fn.getcwd() .. '.project.lua'
if vim.fn.filereadable(project_config) == 1 then
  dofile(project_config)
end

require 'config.mappings'

if vim.fn.has 'win32' == 1 or vim.fn.has 'win64' == 1 then
  require 'config.windows'
end

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '~/.config/nvim/lua/plugins/*.lua',
  command = "lua ReloadLuaFiles(vim.fn.expand('~/.config/nvim/lua/plugins'))",
})

vim.filetype.add {
  extension = {
    c3 = 'c3',
    c3i = 'c3',
    c3t = 'c3',
  },
}

local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.c3 = {
  install_info = {
    url = 'https://github.com/c3lang/tree-sitter-c3',
    files = { 'src/parser.c', 'src/scanner.c' },
    branch = 'main',
  },
}

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
