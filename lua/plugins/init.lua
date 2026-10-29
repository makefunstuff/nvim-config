local treesitter_parsers = {
  'bash',
  'c',
  'c3',
  'diff',
  'dockerfile',
  'go',
  'html',
  'javascript',
  'json',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'odin',
  'python',
  'query',
  'rust',
  'toml',
  'typescript',
  'vim',
  'vimdoc',
  'yaml',
  'zig',
}

return {
  { 'ChmaraX/herdr-nvim', opts = {} },
  { 'nvim-focus/focus.nvim', version = false, opts = {} },
  'tpope/vim-sleuth',
  {
    'obsidian-nvim/obsidian.nvim',
    version = '*', -- use latest release, remove to use latest commit
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
      legacy_commands = false, -- this will be removed in 4.0.0
      workspaces = {
        {
          name = 'personal',
          path = '~/Documents/personal-kb/',
        },
        {
          name = 'education',
          path = '~/Education/vault/',
        },
      },
    },
  },

  { -- Colorscheme
    'Shatur/neovim-ayu',
    lazy = false,
    priority = 1000,
    config = function()
      local colors = require 'ayu.colors'
      colors.generate()
      require('ayu').setup {
        overrides = {
          FloatBorder = { fg = colors.comment, bg = 'none' },
          NormalFloat = { bg = 'none' },
          WinSeparator = { fg = colors.guide_normal },
          CursorLineNr = { fg = colors.accent, bold = true },
        },
      }
      vim.cmd.colorscheme 'ayu-dark'
    end,
  },

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      preset = 'helix',
      icons = { mappings = vim.g.have_nerd_font },
      spec = {
        { '<leader>d', group = 'debug / diagnostics' },
        { '<leader>f', group = 'find' },
        { '<leader>h', group = 'git hunk', mode = { 'n', 'v' } },
        { '<leader>s', group = 'search' },
        { '<leader>t', group = 'toggle / trouble' },
        { '<leader>w', group = 'workspace / whichkey' },
      },
    },
  },

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = 'master',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          prompt_prefix = '   ',
          selection_caret = ' ',
          entry_prefix = '  ',
          sorting_strategy = 'ascending',
          layout_config = {
            horizontal = { prompt_position = 'top', preview_width = 0.55 },
            width = 0.87,
            height = 0.8,
          },
          borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      keywords = {
        TODO = { color = '#2aa330' },
        WARN = { color = '#af3139' },
        NOTE = { color = '#894a7a' },
      },
      gui_style = {
        fg = 'BOLD',
        bg = 'BOLD',
      },
      highlight = {
        after = 'empty',
        keyword = 'fg',
        pattern = [[.*<(KEYWORDS)\s*]],
      },
      signs = false,
      search = {
        command = 'rg',
        args = {
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
        },
        pattern = [[.*<(KEYWORDS)\(\w*\)\s*]],
      },
    },
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    lazy = false,
    priority = 900,
    config = function()
      -- Icons, also standing in for nvim-web-devicons (telescope, trouble, ...)
      require('mini.icons').setup()
      MiniIcons.mock_nvim_web_devicons()

      -- Better Around/Inside textobjects (va), yinq, ci')
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (saiw), sd', sr)')
      require('mini.surround').setup()

      -- Colour hex codes like #ffaa00 in place
      local hipatterns = require 'mini.hipatterns'
      hipatterns.setup {
        highlighters = { hex_color = hipatterns.gen_highlighter.hex_color() },
      }

      -- Start screen when Neovim opens without a file
      local starter = require 'mini.starter'
      starter.setup {
        evaluate_single = true,
        items = {
          starter.sections.recent_files(6, true, false),
          starter.sections.builtin_actions(),
        },
        content_hooks = {
          starter.gen_hook.adding_bullet '  ',
          starter.gen_hook.aligning('center', 'center'),
        },
      }

      local statusline = require 'mini.statusline'
      statusline.setup {
        use_icons = vim.g.have_nerd_font,
        content = {
          active = function()
            local mode, mode_hl = statusline.section_mode { trunc_width = 120 }
            local git = statusline.section_git { trunc_width = 40 }
            local diff = statusline.section_diff { trunc_width = 75 }
            local diagnostics = statusline.section_diagnostics { trunc_width = 75 }
            local lsp = statusline.section_lsp { trunc_width = 75 }
            local filename = statusline.section_filename { trunc_width = 140 }
            local fileinfo = statusline.section_fileinfo { trunc_width = 120 }

            local ok, pair = pcall(require, 'pair')
            local pair_status = ok and pair.status():gsub('%%', '%%%%') or ''

            return statusline.combine_groups {
              { hl = mode_hl, strings = { mode } },
              { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
              '%<',
              { hl = 'MiniStatuslineFilename', strings = { filename } },
              '%=',
              { hl = 'MiniStatuslineFilename', strings = { pair_status } },
              { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
              { hl = mode_hl, strings = { '%2l:%-2v' } },
            }
          end,
        },
      }
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local treesitter = require 'nvim-treesitter'
      treesitter.setup()
      treesitter.install(treesitter_parsers)

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('custom-treesitter', { clear = true }),
        callback = function(event)
          if not pcall(vim.treesitter.start, event.buf) then
            return
          end

          local filetype = vim.bo[event.buf].filetype
          local language = vim.treesitter.language.get_lang(filetype) or filetype
          local has_indents, query = pcall(vim.treesitter.query.get, language, 'indents')
          if has_indents and query then
            vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  {
    'makefunstuff/sketchbook.nvim',
    lazy = false,
    config = function()
      require('sketchbook').setup {
        keymaps = {
          select_template = '<leader>tmp',
        },
      }
    end,
  },
  {
    'tpope/vim-fugitive',
    event = 'BufReadPost',
    cmd = { 'Git', 'G' },
  },
  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    keys = {
      { '<leader>tx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
      { '<leader>tX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
      { '<leader>ts', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Symbols (Trouble)' },
      { '<leader>tl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = 'LSP Definitions / references / ... (Trouble)' },
      { '<leader>tL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)' },
      { '<leader>tQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)' },
    },
  },

  require 'plugins.pair',
  require 'plugins.cmp',
  require 'plugins.lsp',
  require 'plugins.autopairs',
  require 'plugins.conform',
  require 'plugins.debug',
  require 'plugins.gitsigns',
  require 'plugins.indent_line',
  require 'plugins.treesitter-text-objects',
}
