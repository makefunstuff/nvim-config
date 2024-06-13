require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<leader>tt", "<cmd>Telescope<CR>", { desc = "Open Telescope" })
map("n", "<leader>tg", "<cmd>Telescope git_files<CR>", { desc = "Telescope git files search" })

-- add ctrl + shift + p to open Telescope
map("n", "<C-S-P>", "<cmd>Telescope<CR>", { desc = "Open Telescope" })
