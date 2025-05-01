-- Final Keymaps File
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap -- Alias for easier keybinding

-- 🚀 Better File Navigation 🚀 --
keymap.set("n", "<leader>e", ":Ex<CR>", { desc = "Toggle File Explorer" })
keymap.set("n", "<leader>pv", ":Ex<CR>", { desc = "File Explorer (Netrw Fallback)" })
keymap.set("n", "<leader>ps", ":w!<CR>", { desc = "Save File" })
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

-- 🚀 Telescope (Fuzzy Finder) 🚀 --
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find Files" })
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Search Text" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "List Open Buffers" })
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Find Help" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent Files" })
keymap.set("n", "<leader>fc", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Find in Current Buffer" })
keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<CR>", { desc = "Find Word Under Cursor" })
keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", { desc = "Find Diagnostics" })
keymap.set("n", "<leader>fs", function()
    require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Find String" })
keymap.set("n", "<leader>fp", "<cmd>Telescope projects<CR>", { desc = "Find Projects" })
keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find TODOs" })
keymap.set("n", "<leader>fm", "<cmd>Telescope marks<CR>", { desc = "Browse Bookmarks" })
keymap.set("n", "<leader>fM", "<cmd>Telescope man_pages<CR>", { desc = "Search Man Pages" })
keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Show Keymaps" })
keymap.set("n", "<leader>fC", "<cmd>Telescope commands<CR>", { desc = "Show Commands" })
keymap.set("n", "<leader>fS", "<cmd>Telescope git_status<CR>", { desc = "Git Status" })

-- 🚀 Git Integration 🚀 --
keymap.set("n", "<leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "Git Stage Hunk" })
keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Git Reset Hunk" })
keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Git Preview Hunk" })

-- 🚀 LSP (Language Server Protocol) 🚀 --
keymap.set("n", "gd", ":lua vim.lsp.buf.definition()<CR>", { desc = "Go to Definition" })
keymap.set("n", "gr", ":lua vim.lsp.buf.references()<CR>", { desc = "Find References" })
keymap.set("n", "K", ":lua vim.lsp.buf.hover()<CR>", { desc = "Hover Documentation" })
keymap.set("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", { desc = "Go to Implementation" })
keymap.set("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", { desc = "Rename Symbol" })

-- 🚀 Debugging 🚀 --
keymap.set("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", { desc = "Toggle Breakpoint" })
keymap.set("n", "<leader>dc", ":lua require'dap'.continue()<CR>", { desc = "Continue Debugging" })