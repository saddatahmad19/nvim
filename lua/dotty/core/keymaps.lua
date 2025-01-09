-- Final Keymaps File
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap -- Alias for easier keybinding

-- 🚀 Better File Navigation 🚀 --
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })
keymap.set("n", "<leader>pv", ":Ex<CR>", { desc = "File Explorer (Netrw Fallback)" })
keymap.set("n", "<leader>ps", ":w!<CR>", { desc = "Save File" })
keymap.set("n", "<leader>w", ":w!<CR>", { desc = "Save File" })
keymap.set("n", "<leader>q", ":q!<CR>", { desc = "Close File" })
keymap.set("n", "<leader>x", ":x!<CR>", { desc = "Save and Exit" })
keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Close Current Buffer" })
keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next Buffer" })
keymap.set("n", "<leader>bp", ":bprev<CR>", { desc = "Previous Buffer" })

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
keymap.set("n", "<leader>tt", "<cmd>tabnew<CR>", { desc = "Open New Tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close Current Tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Next Tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Previous Tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open Current Buffer in New Tab" })

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

-- 🚀 NvimTree 🚀 --
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })
keymap.set("n", "<leader>fe", ":NvimTreeFindFile<CR>", { desc = "Find Current File" })
