return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    { 'folke/snacks.nvim', opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    vim.g.opencode_opts = vim.g.opencode_opts or {}
    vim.g.opencode_opts.provider = { enabled = 'tmux' }
    vim.o.autoread = true

    local opencode = require 'opencode'
    local config = require 'opencode.config'

    -- Override built-in tmux split with a floating popup provider
    local popup = require('custom.opencode_popup').new {
      width = '80%',
      height = '80%',
    }
    popup.cmd = config.opts.provider.cmd or 'opencode --port'
    config.provider = popup

    local function map(mode, l, r, opts)
      opts = opts or {}
      vim.keymap.set(mode, l, r, opts)
    end
    map({ 'n', 'x' }, '<leader>oa', function()
      opencode.ask('@this: ', { submit = true })
    end, { desc = 'Ask opencode' })
    map({ 'n', 'x' }, '<leader>ox', function()
      opencode.select()
    end, { desc = 'Opencode actions' })
    map({ 'n', 't' }, '<leader>oo', function()
      opencode.toggle()
    end, { desc = 'Toggle opencode' })

    map({ 'n', 'x' }, 'go', function()
      return opencode.operator '@this '
    end, { desc = 'Add range to opencode', expr = true })
    map('n', 'goo', function()
      return opencode.operator '@this ' .. '_'
    end, { desc = 'Add line to opencode', expr = true })
  end,
}
