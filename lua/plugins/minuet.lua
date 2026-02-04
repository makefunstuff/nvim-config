return {
  'milanglacier/minuet-ai.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('minuet').setup {
      provider = 'openai_compatible',
      n_completions = 1,
      context_window = 1024,
      throttle = 500,
      debounce = 300,
      notify = 'error',
      provider_options = {
        openai_compatible = {
          api_key = 'TERM',
          end_point = 'http://localhost:11434/v1/chat/completions',
          model = 'hf.co/sweepai/sweep-next-edit-1.5B:latest',
          name = 'Ollama',
          optional = {
            max_tokens = 128,
            top_p = 0.9,
            temperature = 0.2,
          },
        },
      },
      -- Ghost text completions
      virtualtext = {
        auto_trigger_ft = { '*' },
        keymap = {
          accept = '<A-a>',
          accept_line = '<A-l>',
          prev = '<A-[>',
          next = '<A-]>',
          dismiss = '<A-e>',
        },
      },
      -- blink.cmp integration configured in cmp.lua
      blink = {
        enable_auto_complete = true,
      },
    }

    -- Manual trigger keymap for ghost text
    vim.keymap.set('i', '<A-m>', function()
      require('minuet').make_request()
    end, { desc = 'Minuet: trigger completion' })
  end,
}
