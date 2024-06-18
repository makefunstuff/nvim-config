require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local harpoon = require "harpoon.mark"
local ui = require "harpoon.ui"

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<leader>tt", "<cmd>Telescope<CR>", { desc = "Open Telescope" })
map("n", "<leader>tg", "<cmd>Telescope git_files<CR>", { desc = "Telescope git files search" })

-- add ctrl + shift + p to open Telescope
map("n", "<C-S-P>", "<cmd>Telescope<CR>", { desc = "Open Telescope" })
map("n", "<C-p>", "<cmd>Telescope live_grep<CR>", { desc = "Telescope git files search" })

map("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint" })
map("n", "<leader>dus", function()
  local widgets = require "dap.ui.widgets"
  local sidebar = widgets.sidebar(widgets.scopes)
  sidebar.open()
end, { desc = "Open debugging sidebar" })
map("n", "<leader>dr", "<cmd> DapContinue<CR>", { desc = "Start or continue debugger" })
map("n", "<leader>dte", "<cmd> TransparentToggle<CR>", { desc = "Toggle transparent" })
map("n", "<leader>dtm", harpoon.add_file, { desc = "Add file to harpoon" })
map("n", "<leader>dtq", ui.toggle_quick_menu, { desc = "Toggle harpoon" })
