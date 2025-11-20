return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	dependencies = {
		{ "echasnovski/mini.icons", version = false },
	},
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	config = function()
		local wk = require("which-key")

		local leader_mappings = {
			{ "<leader><space>", function() wk.show(" ", { mode = "n", auto = true }) end, desc = "Command Palette" },

			-- Telescope mappings
			{ "<leader>f", group = "Find/Files" },
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
			{ "<leader>fc", "<cmd>Telescope grep_string<cr>", desc = "Find Word Under Cursor" },
			{ "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
			{ "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
			{
				"<leader>fs",
				function()
					require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
				end,
				desc = "Search String",
			},
			{ "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Browse Bookmarks" },
			{ "<leader>fM", "<cmd>Telescope man_pages<cr>", desc = "Search Man Pages" },
			{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Show Keymaps" },
			{ "<leader>fC", "<cmd>Telescope commands<cr>", desc = "Show Commands" },
			{ "<leader>fS", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "List Open Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
			{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Find Diagnostics" },
			{ "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Find Projects" },
			{ "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Find Word Under Cursor" },

			-- Buffer management (barbar.nvim)
			{ "<leader>b", group = "Buffers" },
			{ "<leader>b1", "<cmd>BufferGoto 1<cr>", desc = "Go to buffer 1" },
			{ "<leader>b2", "<cmd>BufferGoto 2<cr>", desc = "Go to buffer 2" },
			{ "<leader>b3", "<cmd>BufferGoto 3<cr>", desc = "Go to buffer 3" },
			{ "<leader>b4", "<cmd>BufferGoto 4<cr>", desc = "Go to buffer 4" },
			{ "<leader>b5", "<cmd>BufferGoto 5<cr>", desc = "Go to buffer 5" },
			{ "<leader>bc", "<cmd>BufferClose<cr>", desc = "Close buffer" },
			{ "<leader>bo", "<cmd>BufferCloseAllButCurrent<cr>", desc = "Close other buffers" },
			{ "<leader>bp", "<cmd>BufferPick<cr>", desc = "Pick buffer" },

			-- LSP actions
			{ "<leader>c", group = "Code" },
			{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action" },
			{ "<leader>cd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
			{ "<leader>cD", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Buffer Diagnostics" },
			{ "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
			{ "<leader>cs", "<cmd>LspRestart<cr>", desc = "Restart LSP" },

			-- Git / Diffview
			{ "<leader>g", group = "Git" },
			{ "<leader>gs", "<cmd>Git<cr>", desc = "Git Status" },
			{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
			{ "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "File History" },
			{ "<leader>gl", "<cmd>DiffviewLog<cr>", desc = "Git Log" },
			{ "<leader>gf", "<cmd>DiffviewFocusFiles<cr>", desc = "Focus Files" },
			{ "<leader>gt", "<cmd>DiffviewToggleFiles<cr>", desc = "Toggle Files" },

			-- Sessions (persistence.nvim)
			{ "<leader>q", group = "Sessions" },
			{
				"<leader>qs",
				function() require("persistence").load() end,
				desc = "Restore Session",
			},
			{
				"<leader>ql",
				function() require("persistence").load({ last = true }) end,
				desc = "Restore Last Session",
			},
			{
				"<leader>qd",
				function() require("persistence").stop() end,
				desc = "Don't Save Session",
			},
		}

		wk.add(leader_mappings)

		local general_mappings = {
			{ "g", group = "LSP Navigation" },
			{ "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Go to Definition" },
			{ "gD", vim.lsp.buf.declaration, desc = "Go to Declaration" },
			{ "gi", "<cmd>Telescope lsp_implementations<cr>", desc = "Go to Implementation" },
			{ "gr", "<cmd>Telescope lsp_references<cr>", desc = "Find References" },
			{ "gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Type Definition" },
			{ "K", vim.lsp.buf.hover, desc = "Show Documentation" },

			-- Diagnostic navigation
			{ "]d", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
			{ "[d", vim.diagnostic.goto_prev, desc = "Previous Diagnostic" },

			-- Buffer navigation (barbar.nvim)
			{ "]b", "<cmd>BufferNext<cr>", desc = "Next Buffer" },
			{ "[b", "<cmd>BufferPrevious<cr>", desc = "Previous Buffer" },
			{ "<S-l>", "<cmd>BufferNext<cr>", desc = "Next Buffer" },
			{ "<S-h>", "<cmd>BufferPrevious<cr>", desc = "Previous Buffer" },
		}

		wk.add(general_mappings)
	end,
}
