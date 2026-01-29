return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  version = false, -- Never set this value to "*"! Never!
  opts = {
    -- Default provider (can switch with keybindings)
    provider = 'claude',

    -- Mode: "agentic" uses tools for code gen, "legacy" uses planning
    mode = 'agentic',

    -- All providers in unified table (new format)
    providers = {
      -- Claude (direct API)
      claude = {
        endpoint = 'https://api.anthropic.com',
        model = 'claude-sonnet-4-20250514',
        timeout = 30000,
        extra_request_body = {
          temperature = 0,
          max_tokens = 16384,
        },
      },

      -- OpenAI via OpenRouter
      openai = {
        endpoint = 'https://openrouter.ai/api/v1',
        model = 'openai/gpt-4o',
        timeout = 30000,
        extra_request_body = {
          temperature = 0,
          max_tokens = 8192,
        },
      },

      -- OpenRouter Gemini
      ['openrouter-gemini'] = {
        __inherited_from = 'openai',
        endpoint = 'https://openrouter.ai/api/v1',
        model = 'google/gemini-2.0-flash-001',
        timeout = 30000,
        extra_request_body = {
          temperature = 0,
          max_tokens = 8192,
        },
      },

      -- OpenRouter Claude
      ['openrouter-claude'] = {
        __inherited_from = 'openai',
        endpoint = 'https://openrouter.ai/api/v1',
        model = 'anthropic/claude-sonnet-4-20250514',
        timeout = 30000,
        extra_request_body = {
          temperature = 0,
          max_tokens = 16384,
        },
      },
    },

    -- ACP (Agent Client Protocol) providers
    acp_providers = {
      ['claude-code'] = {
        command = 'npx',
        args = { '@zed-industries/claude-code-acp' },
        env = {
          NODE_NO_WARNINGS = '1',
          ANTHROPIC_API_KEY = os.getenv 'ANTHROPIC_API_KEY',
        },
      },
      ['opencode'] = {
        command = 'opencode',
        args = { 'acp' },
      },
      ['gemini-cli'] = {
        command = 'gemini',
        args = { '--experimental-acp' },
        env = {
          NODE_NO_WARNINGS = '1',
          GEMINI_API_KEY = os.getenv 'GEMINI_API_KEY',
        },
      },
      ['codex'] = {
        command = 'npx',
        args = { '@zed-industries/codex-acp' },
        env = {
          NODE_NO_WARNINGS = '1',
          OPENAI_API_KEY = os.getenv 'OPENAI_API_KEY',
        },
      },
      ['goose'] = {
        command = 'goose',
        args = { 'acp' },
      },
    },

    -- RAG service for codebase understanding
    rag_service = {
      enabled = true,
      host_mount = os.getenv 'HOME',
      provider = 'openai',
      endpoint = 'https://openrouter.ai/api/v1',
    },

    -- Web search
    web_search_engine = {
      provider = 'tavily',
    },

    -- File selector
    file_selector = {
      provider = 'telescope',
    },

    -- Hints for better UX
    hints = { enabled = true },

    -- Windows
    windows = {
      position = 'right',
      width = 40,
      sidebar_header = {
        enabled = true,
        align = 'center',
        rounded = true,
      },
    },
  },

  -- Keybindings for provider switching and Avante commands
  keys = {
    { '<leader>aa', '<cmd>AvanteAsk<cr>', desc = 'Avante: Ask' },
    { '<leader>ac', '<cmd>AvanteChat<cr>', desc = 'Avante: Chat' },
    { '<leader>ae', '<cmd>AvanteEdit<cr>', desc = 'Avante: Edit', mode = { 'n', 'v' } },
    { '<leader>at', '<cmd>AvanteToggle<cr>', desc = 'Avante: Toggle' },
    { '<leader>ar', '<cmd>AvanteRefresh<cr>', desc = 'Avante: Refresh' },
    { '<leader>az', '<cmd>AvanteZenMode<cr>', desc = 'Avante: Zen Mode (ACP)' },
    -- Provider switching
    { '<leader>apc', '<cmd>AvanteSwitchProvider claude<cr>', desc = 'Avante: Claude' },
    { '<leader>apo', '<cmd>AvanteSwitchProvider openai<cr>', desc = 'Avante: OpenAI' },
    { '<leader>apg', '<cmd>AvanteSwitchProvider openrouter-gemini<cr>', desc = 'Avante: Gemini (OpenRouter)' },
    -- ACP providers
    { '<leader>apC', '<cmd>AvanteSwitchProvider claude-code<cr>', desc = 'Avante: Claude Code (ACP)' },
    { '<leader>apO', '<cmd>AvanteSwitchProvider opencode<cr>', desc = 'Avante: OpenCode (ACP)' },
  },

  build = 'make',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'echasnovski/mini.pick',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
    {
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = { insert_mode = true },
          use_absolute_path = true,
        },
      },
    },
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = { file_types = { 'markdown', 'Avante' } },
      ft = { 'markdown', 'Avante' },
    },
  },
}
