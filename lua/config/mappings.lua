local map = vim.keymap.set

map('i', '<C-b>', '<ESC>^i', { desc = 'move beginning of line' })
map('i', '<C-e>', '<End>', { desc = 'move end of line' })
map('i', '<C-h>', '<Left>', { desc = 'move left' })
map('i', '<C-l>', '<Right>', { desc = 'move right' })
map('i', '<C-j>', '<Down>', { desc = 'move down' })
map('i', '<C-k>', '<Up>', { desc = 'move up' })

map('n', '<C-h>', '<C-w>h', { desc = 'switch window left' })
map('n', '<C-l>', '<C-w>l', { desc = 'switch window right' })
map('n', '<C-j>', '<C-w>j', { desc = 'switch window down' })
map('n', '<C-k>', '<C-w>k', { desc = 'switch window up' })

map('n', '<C-s>', '<cmd>w<CR>', { desc = 'General Save file' })
map('n', '<C-c>', '<cmd>%y+<CR>', { desc = 'General Copy whole file' })

map('n', '<leader>n', '<cmd>set nu!<CR>', { desc = 'Toggle line number' })
map('n', '<leader>rn', '<cmd>set rnu!<CR>', { desc = 'Toggle relative number' })
map('n', '<leader>ch', '<cmd>NvCheatsheet<CR>', { desc = 'Toggle nvcheatsheet' })

map('n', '<leader>fm', function()
  require('conform').format { lsp_fallback = true }
end, { desc = 'General Format file' })

-- global lsp mappings
map('n', '<leader>ds', vim.diagnostic.setloclist, { desc = 'LSP Diagnostic loclist' })

-- Comment
map('n', '<leader>/', 'gcc', { desc = 'Toggle Comment', remap = true })
map('v', '<leader>/', 'gc', { desc = 'Toggle comment', remap = true })

-- netwrw
map('n', '<C-n>', '<cmd>e .<CR>', { desc = 'Open netrw' })

-- telescope
map('n', '<leader>fw', '<cmd>Telescope live_grep<CR>', { desc = 'telescope live grep' })
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { desc = 'telescope find buffers' })
map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { desc = 'telescope help page' })
map('n', '<leader>ma', '<cmd>Telescope marks<CR>', { desc = 'telescope find marks' })
map('n', '<leader>fo', '<cmd>Telescope oldfiles<CR>', { desc = 'telescope find oldfiles' })
map('n', '<leader>fz', '<cmd>Telescope current_buffer_fuzzy_find<CR>', { desc = 'telescope find in current buffer' })
map('n', '<leader>cm', '<cmd>Telescope git_commits<CR>', { desc = 'telescope git commits' })
map('n', '<leader>gt', '<cmd>Telescope git_status<CR>', { desc = 'telescope git status' })
map('n', '<leader>pt', '<cmd>Telescope terms<CR>', { desc = 'telescope pick hidden term' })
map('n', '<leader>th', '<cmd>Telescope themes<CR>', { desc = 'telescope nvchad themes' })
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'telescope find files' })
map('n', '<leader>fa', '<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>', { desc = 'telescope find all files' })

-- terminal
map('t', '<C-x>', '<C-\\><C-N>', { desc = 'terminal escape terminal mode' })

-- whichkey
map('n', '<leader>wK', '<cmd>WhichKey <CR>', { desc = 'whichkey all keymaps' })

map('n', '<leader>wk', function()
  vim.cmd('WhichKey ' .. vim.fn.input 'WhichKey: ')
end, { desc = 'whichkey query lookup' })

map('n', ';', ':', { desc = 'CMD enter command mode' })
map('i', 'jk', '<ESC>')

map('n', '<leader>tt', '<cmd>Telescope<CR>', { desc = 'Open Telescope' })
map('n', '<leader>tg', '<cmd>Telescope git_files<CR>', { desc = 'Telescope git files search' })

map('n', '<C-p>', '<cmd> Telescope find_files<CR>', { desc = 'Telescope git files search' })

map('n', '<leader>db', '<cmd>DapToggleBreakpoint<CR>', { desc = 'Toggle breakpoint' })
map('n', '<leader>dr', '<cmd> DapContinue<CR>', { desc = 'Start or continue debugger' })

map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

--- compile
map('n', '<leader>mb', '<cmd>make<CR>', { desc = 'Compile project' })
