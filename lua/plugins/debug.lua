return {

  'mfussenegger/nvim-dap',
  dependencies = {
    'leoluz/nvim-dap-go',
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
    'julianolf/nvim-dap-lldb',
  },
  config = function()
    local dap = require 'dap'
    local ui = require 'dapui'

    require('dapui').setup()
    require('dap-go').setup()

    require('dap-lldb').setup()

    dap.configurations.zig = {
      {
        name = 'Debug Zig With Arguments',
        type = 'lldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        args = function()
          local input = vim.fn.input 'Arguments: '
          return vim.split(input, ' ')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        runInTerminal = false,
      },
      {
        name = 'Debug Zig Without Arguments',
        type = 'lldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        args = {},
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        runInTerminal = false,
      },
    }

    dap.configurations.odin = {
      {
        name = 'Debug Odin With Arguments',
        type = 'lldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        args = function()
          local input = vim.fn.input 'Arguments: '
          return vim.split(input, ' ')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        runInTerminal = false,
      },
      {
        name = 'Debug Odin Without Arguments',
        type = 'lldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        args = {},
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        runInTerminal = false,
      },
    }
    vim.keymap.set('n', '<space>gb', dap.run_to_cursor)
    -- Eval var under cursor
    vim.keymap.set('n', '<space>?', function()
      require('dapui').eval(nil, { enter = true })
    end)
    vim.keymap.set('n', '<F1>', dap.continue)
    vim.keymap.set('n', '<F2>', dap.step_into)
    vim.keymap.set('n', '<F3>', dap.step_over)
    vim.keymap.set('n', '<F4>', dap.step_out)
    vim.keymap.set('n', '<F5>', dap.step_back)
    vim.keymap.set('n', '<F13>', dap.restart)

    dap.listeners.after.event_initialized['dapui_config'] = ui.open
    dap.listeners.before.event_terminated['dapui_config'] = ui.close
    dap.listeners.before.event_exited['dapui_config'] = ui.close

    vim.keymap.set('n', '<leader>du', ui.toggle, { desc = 'DAP: UI Toggle' })
    dap.listeners.before.attach.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      ui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      ui.close()
    end
  end,
}, {
  'jay-babu/mason-nvim-dap.nvim',
  event = 'VeryLazy',
  dependencies = {
    'williamboman/mason.nvim',
    'mfussenegger/nvim-dap',
  },
  opts = {
    handlers = {},
    ensure_installed = {
      'dlv',
      'codelldb',
    },
  },
}
