-- lua/dotty/core/os.lua
--
-- A simple utility module to detect the operating system.
-- This helps in conditionally loading plugins or applying settings
-- specific to an OS.

local M = {}

--- Returns true if the current operating system is Windows.
-- @return boolean
M.is_windows = function()
  return vim.fn.has("win32") == 1
end

return M