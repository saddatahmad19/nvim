local opt = vim.opt

-- 🚀 General Editor Behavior 🚀 --
opt.number = true -- Show line numbers
opt.relativenumber = true -- Enable relative line numbers

-- 🚀 Indentation 🚀 --
opt.tabstop = 4 -- Use 4 spaces for tabs
opt.shiftwidth = 4 -- Indentation width
opt.expandtab = true -- Convert tabs to spaces
opt.autoindent = true -- Auto-indent new lines

-- 🚀 Search Enhancements 🚀 --
opt.ignorecase = true -- Case-insensitive search
opt.smartcase = true -- Case-sensitive if uppercase letters present
opt.hlsearch = false -- Don't highlight search matches

-- 🚀 UI Improvements 🚀 --
opt.cursorline = true -- Highlight the current line
opt.termguicolors = true -- Enable true colors
opt.signcolumn = "yes" -- Always show the sign column

-- 🚀 Clipboard 🚀 --
opt.clipboard = "unnamedplus" -- Use system clipboard

-- 🚀 Splits 🚀 --
opt.splitright = true -- Vertical split to the right
opt.splitbelow = true -- Horizontal split below

-- 🚀 Performance 🚀 --
opt.updatetime = 250 -- Faster update time for plugins
opt.timeoutlen = 400 -- Faster key sequence timeout

-- 🚀 File Handling 🚀 --
opt.swapfile = false -- Disable swap files
opt.undofile = true -- Persistent undo history

-- 🚀 Miscellaneous 🚀 --
opt.scrolloff = 10 -- Keep cursor centered when scrolling
opt.sidescrolloff = 8 -- Minimum columns to keep to the left/right
