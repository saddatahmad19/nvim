return {
	"nvim-neorg/neorg",
	build = ":Neorg sync-parsers",
	dependencies = { 
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	lazy = false,
	version = "*",
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {}, -- Loads default behaviour
				["core.concealer"] = {  -- Adds pretty icons to your documents
					config = {
						icon_preset = "diamond",
						icons = {
							code_block = {
								conceal = true,
								width = "content",
							},
						},
					},
				},
				["core.dirman"] = { -- Manages Neorg workspaces
					config = {
						workspaces = {
							notes = "~/Desktop/Notes/code-notes",
							journal = "~/Desktop/Notes/code-notes/journal",
							projects = "~/Desktop/Notes/code-notes/projects",
						},
						default_workspace = "notes",
						index = "index.norg",
					},
				},
				["core.completion"] = {
					config = {
						engine = "nvim-cmp",
					},
				},
				["core.integrations.treesitter"] = {}, -- Required for syntax
				["core.export"] = {}, -- Enable export module
				["core.export.markdown"] = {}, -- Enable markdown export
				["core.summary"] = {}, -- Enable summary module
				["core.esupports.metagen"] = {}, -- Enable metadata generation
				["core.journal"] = { -- Enable journaling
					config = {
						strategy = "flat",
					},
				},
				["core.qol.toc"] = {}, -- Enable table of contents
				["core.keybinds"] = { -- Manages keybindings
					config = {
						default_keybinds = true,
						neorg_leader = "<Leader>n",
						hook = function(keybinds)
							-- General note management
							keybinds.map("norg", "n", "<leader>nn", "<cmd>Neorg workspace notes<CR>")
							keybinds.map("norg", "n", "<leader>nj", "<cmd>Neorg workspace journal<CR>")
							keybinds.map("norg", "n", "<leader>np", "<cmd>Neorg workspace projects<CR>")
							
							-- Navigation
							keybinds.map("norg", "n", "<leader>ni", "<cmd>Neorg index<CR>")
							keybinds.map("norg", "n", "<leader>nr", "<cmd>Neorg return<CR>")
							
							-- TOC and Metadata
							keybinds.map("norg", "n", "<leader>nt", "<cmd>Neorg toc<CR>")
							keybinds.map("norg", "n", "<leader>nm", "<cmd>Neorg inject-metadata<CR>")
							
							-- Export
							keybinds.map("norg", "n", "<leader>ne", "<cmd>Neorg export to-file<CR>")
							keybinds.map("norg", "n", "<leader>nE", "<cmd>Neorg export to-markdown<CR>")
						end,
					},
				},
			},
		})
	end,
}
