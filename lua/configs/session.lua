-- Set session options
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

local session_file = "~/.auto_session.nvim"
-- Auto save session on exit
vim.api.nvim_create_autocmd({ "VimLeave" }, {
  callback = function()
    vim.cmd("mksession! " .. session_file)
  end,
})

-- Auto restore session on start
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    if vim.fn.filereadable(session_file) == 1 then
      vim.cmd("source " .. session_file)
    end
  end,
})
