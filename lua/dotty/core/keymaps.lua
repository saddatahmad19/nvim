-- Final Keymaps File
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap -- Alias for easier keybinding

-- 🚀 Better File Navigation 🚀 --
keymap.set("n", "<leader>e", ":Ex<CR>", { desc = "Toggle File Explorer" })
keymap.set("n", "<leader>pv", ":Ex<CR>", { desc = "File Explorer (Netrw Fallback)" })
keymap.set("n", "<leader>ps", function()
  -- Check if conform is available
  local ok, conform = pcall(require, "conform")
  if not ok then
    vim.notify("Conform.nvim not loaded. Saving without formatting.", vim.log.levels.WARN)
    vim.cmd("w!")
    return
  end

  -- Get current buffer
  local bufnr = vim.api.nvim_get_current_buf()

  -- Format the file
  local format_ok, format_err = pcall(function()
    conform.format({
      bufnr = bufnr,
      lsp_fallback = true,
      async = false,
      timeout_ms = 2000,
    })
  end)

  if not format_ok then
    vim.notify("Formatting failed: " .. tostring(format_err), vim.log.levels.WARN)
  end

  -- Save the file
  vim.cmd("w!")
end, { desc = "Format and Save File" })
keymap.set("n", "<leader>w", ":w!<CR>", { desc = "Save File" })
keymap.set("n", "<leader>q", ":q!<CR>", { desc = "Close File" })
keymap.set("n", "<leader>x", ":x!<CR>", { desc = "Save and Exit" })

-- 🚀 Editing Enhancements 🚀 --
keymap.set("i", "jk", "<ESC>", { desc = "Exit Insert Mode Quickly" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear Search Highlights" })

-- 🚀 Increment/Decrement Numbers 🚀 --
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment Number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement Number" })

-- 🚀 Window Management 🚀 --
-- Split Windows
keymap.set("n", "<leader>s|", "<C-w>v", { desc = "Split Window Vertically" })
keymap.set("n", "<leader>s-", "<C-w>s", { desc = "Split Window Horizontally" })
-- Navigate Windows
keymap.set("n", "<leader>sh", "<C-w>h", { desc = "Move to Left Window" })
keymap.set("n", "<leader>sj", "<C-w>j", { desc = "Move to Bottom Window" })
keymap.set("n", "<leader>sk", "<C-w>k", { desc = "Move to Top Window" })
keymap.set("n", "<leader>sl", "<C-w>l", { desc = "Move to Right Window" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize Window Sizes" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close Current Split" })

-- 🚀 Tab Management 🚀 --
-- keymap.set("n", "<leader>tt", "<cmd>enew<CR><cmd>BufferLineCycleNext<CR>", { desc = "Open New Buffer" })
-- keymap.set("n", "<leader>txx", "<cmd>:wq<CR>", { desc = "Close Current Tab" })
-- keymap.set("n", "<leader>txo", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close Current Buffer" })
-- keymap.set("n", "<leader>tl", "<cmd>BufferLineCycleNext<CR>", { desc = "Next Tab" })
-- keymap.set("n", "<leader>th", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous Tab" })
-- keymap.set("n", "<leader>tc", "<cmd>BufferLinePickClose<CR>", { desc = "Pick Buffer to Close" })
-- keymap.set("n", "<leader>tp", "<cmd>BufferLinePick<CR>", { desc = "Pick Buffer" })
-- keymap.set("n", "<leader>ts", "<cmd>BufferLineSortByDirectory<CR>", { desc = "Sort Buffers" })

-- 🚀 Telescope, Git, and LSP keymaps are handled by which_key.lua and plugin configs 🚀 --
-- Removed duplicates to avoid conflicts

-- 🚀 Plugin Management 🚀 --
keymap.set("n", "<leader>fu", "<cmd>Lazy update<cr>", { desc = "Update Plugins (Lazy)" })

-- 🚀 Debugging 🚀 --
keymap.set("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", { desc = "Toggle Breakpoint" })
keymap.set("n", "<leader>dc", ":lua require'dap'.continue()<CR>", { desc = "Continue Debugging" })