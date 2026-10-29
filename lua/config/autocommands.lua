vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('custom-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
  desc = 'Reload a config module when it is saved',
  group = vim.api.nvim_create_augroup('custom-config-reload', { clear = true }),
  pattern = '*.lua',
  callback = function(args)
    local config_dir = vim.fn.stdpath 'config'
    local rel = args.file:match('^' .. vim.pesc(config_dir) .. '/lua/(.+)%.lua$')
    if not rel then
      return
    end

    local module = rel:gsub('/', '.')
    package.loaded[module] = nil
    pcall(require, module)
  end,
})
