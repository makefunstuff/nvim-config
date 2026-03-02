--- Custom tmux display-popup provider for opencode.nvim
--- Opens opencode in a floating tmux popup instead of a split pane.
--- Uses a persistent tmux session so opencode survives popup dismiss.
--- Close with: prefix + o (Ctrl-s o) to toggle, or quit opencode.

---@class custom.OpenCodePopup : opencode.Provider
---@field opts custom.OpenCodePopup.Opts
---@field session string
local M = {}
M.__index = M
M.name = 'tmux-popup'

---@class custom.OpenCodePopup.Opts
---@field width? string Popup width (default "80%")
---@field height? string Popup height (default "80%")
---@field session? string Tmux session name for persistence (default "popup-opencode")

---@param opts? custom.OpenCodePopup.Opts
---@return custom.OpenCodePopup
function M.new(opts)
  local self = setmetatable({}, M)
  self.opts = vim.tbl_deep_extend('force', {
    width = '80%',
    height = '80%',
    session = 'popup-opencode',
  }, opts or {})
  self.session = self.opts.session
  return self
end

function M.health()
  if vim.fn.executable 'tmux' ~= 1 then
    return '`tmux` executable not found', { 'Install tmux' }
  end
  if not vim.env.TMUX then
    return 'Not in a tmux session', { 'Run Neovim inside tmux' }
  end
  return true
end

---@return boolean
function M:_session_exists()
  vim.fn.system('tmux has-session -t ' .. self.session .. ' 2>&1')
  return vim.v.shell_error == 0
end

--- Toggle the opencode popup.
--- Without -E, calling display-popup while one is shown closes it (tmux 3.3+ toggle).
--- The persistent session keeps opencode alive when the popup is dismissed.
--- Also works with the tmux prefix+o binding defined in .tmux.conf.
function M:toggle()
  local w = self.opts.width
  local h = self.opts.height
  local cmd = self.cmd or 'opencode --port'
  local cwd = vim.fn.getcwd()

  -- -A attaches to existing session or creates a new one
  local inner = string.format("tmux new-session -A -s %s '%s || $SHELL'", self.session, cmd)

  -- No -E: popup acts as a toggle (calling display-popup again closes it).
  -- Matches the prefix+o binding in .tmux.conf.
  vim.system {
    'tmux',
    'display-popup',
    '-w', w,
    '-h', h,
    '-d', cwd,
    inner,
  }
end

function M:start()
  self:toggle()
end

--- Kill the background session to fully stop opencode.
function M:stop()
  if self:_session_exists() then
    vim.fn.system('tmux kill-session -t ' .. self.session)
  end
end

return M
