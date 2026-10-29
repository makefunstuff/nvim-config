-- Make Mason-managed tools available to plugins that load before mason.nvim.
for _, tool_path in ipairs { '/opt/homebrew/opt/ruby/bin', vim.fn.stdpath 'data' .. '/mason/bin' } do
  if not vim.env.PATH:find(tool_path, 1, true) then
    vim.env.PATH = tool_path .. ':' .. vim.env.PATH
  end
end

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250
-- faster for whichkey popup
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.cursorline = true
vim.opt.synmaxcol = 300
vim.opt.scrolloff = 10

-- Look
vim.opt.termguicolors = true
vim.opt.winborder = 'rounded'
vim.opt.laststatus = 3
vim.opt.pumheight = 12
vim.opt.smoothscroll = true
vim.opt.fillchars = { eob = ' ', fold = ' ', foldsep = ' ', diff = '╱' }
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.filetype.add {
  extension = {
    fs = 'glsl',
    vs = 'glsl',
    hlsl = 'hlsl',
    fx = 'hlsl',
    c3 = 'c3',
    c3i = 'c3',
    c3t = 'c3',
  },
}
