-- line numbers
vim.opt.number = true

vim.opt.showmode = false

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

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

-- set lazy redraw
vim.opt_global.synmaxcol = 300

vim.opt.scrolloff = 10
vim.wo.relativenumber = true
