return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- optional, for file icons
	},
	config = function()
		-- Configure web-devicons for better looking icons
		local icons = require("dotty.core.icons")

		require("nvim-web-devicons").setup({
			override = {
				default_icon = {
					icon = "󰈚",
					color = "#6d8086",
					name = "Default",
				},
			},
			color_icons = true,
			strict = true,
			override_by_extension = {
				["lua"] = {
					icon = "",
					color = "#51a0cf",
					name = "Lua",
				},
				["py"] = {
					icon = "",
					color = "#ffbc03",
					name = "Python",
				},
				["js"] = {
					icon = "",
					color = "#f7df1e",
					name = "JavaScript",
				},
				["ts"] = {
					icon = "󰛦",
					color = "#3178c6",
					name = "TypeScript",
				},
				["jsx"] = {
					icon = "",
					color = "#61dafb",
					name = "React",
				},
				["tsx"] = {
					icon = "",
					color = "#61dafb",
					name = "ReactTS",
				},
				["vue"] = {
					icon = "󰡄",
					color = "#42b883",
					name = "Vue",
				},
				["svelte"] = {
					icon = "",
					color = "#ff3e00",
					name = "Svelte",
				},
				["html"] = {
					icon = "",
					color = "#e34f26",
					name = "HTML",
				},
				["css"] = {
					icon = "",
					color = "#1572b6",
					name = "CSS",
				},
				["md"] = {
					icon = "",
					color = "#ffffff",
					name = "Markdown",
				},
				["json"] = {
					icon = "",
					color = "#cbcb41",
					name = "JSON",
				},
			},
		})

		local function my_on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- Default mappings
			api.config.mappings.default_on_attach(bufnr)

			-- Custom mappings
			vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
			vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
			vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
			vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
			vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
			vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
			vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
			vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open in Current Window"))
			vim.keymap.set("n", "<Tab>", api.node.open.tab, opts("Open in New Tab"))
			vim.keymap.set("n", "p", api.node.open.preview, opts("Preview File"))
			vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
			vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
			vim.keymap.set("n", ".", api.node.run.cmd, opts("Run Command"))
			vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
			vim.keymap.set("n", "%", api.fs.create, opts("Create"))
			vim.keymap.set("n", "bd", api.marks.bulk.delete, opts("Delete Bookmarked"))
			vim.keymap.set("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
			vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts("Toggle No Buffer"))
			vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
			vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts("Toggle Git Clean"))
			vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
			vim.keymap.set("n", "]c", api.node.navigate.git.next, opts("Next Git"))
			vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
			vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
			vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All"))
			vim.keymap.set("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
			vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
			vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
			vim.keymap.set("n", "F", api.live_filter.clear, opts("Clean Filter"))
			vim.keymap.set("n", "f", api.live_filter.start, opts("Filter"))
			vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))
			vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
			vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
			vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
			vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
			vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
			vim.keymap.set("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
			vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
			vim.keymap.set("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
			vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
			vim.keymap.set("n", "q", api.tree.close, opts("Close"))
			vim.keymap.set("n", "R", api.fs.rename, opts("Rename"))
			vim.keymap.set("n", "r", api.tree.reload, opts("Refresh"))
			vim.keymap.set("n", "s", api.node.run.system, opts("Run System"))
			vim.keymap.set("n", "S", api.tree.search_node, opts("Search"))
			vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
			vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse"))
			vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
			vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
			vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
		end

		require("nvim-tree").setup({
			on_attach = my_on_attach,
			sort_by = "case_sensitive",
			view = {
				width = 35, -- Slightly wider for better readability
				relativenumber = true,
				cursorline = true,
				float = {
					enable = false,
					quit_on_focus_loss = true,
				},
			},
			renderer = {
				add_trailing = true,
				group_empty = true,
				highlight_git = true,
				highlight_opened_files = "name",
				root_folder_label = ":~:s?$?/..?",
				indent_width = 2,
				indent_markers = {
					enable = true,
					inline_arrows = true,
					icons = {
						corner = "└",
						edge = "│",
						item = "│",
						bottom = "─",
						none = " ",
					},
				},
				icons = {
					webdev_colors = true,
					git_placement = "before",
					modified_placement = "after",
					padding = " ",
					symlink_arrow = " ➛ ",
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
						modified = true,
					},
					glyphs = {
						default = "󰈚",
						symlink = "",
						bookmark = "󰆤",
						modified = "●",
						folder = {
							arrow_closed = "",
							arrow_open = "",
							default = "",
							open = "",
							empty = "",
							empty_open = "",
							symlink = "",
							symlink_open = "",
						},
						git = {
							unstaged = "✗",
							staged = "✓",
							unmerged = "",
							renamed = "➜",
							untracked = "★",
							deleted = "",
							ignored = "◌",
						},
					},
				},
				special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
				symlink_destination = true,
			},
			filters = {
				dotfiles = false,
				git_clean = false,
				no_buffer = false,
				custom = { "node_modules", "\\.cache" },
				exclude = {},
			},
			actions = {
				open_file = {
					quit_on_open = false,
					window_picker = {
						enable = true,
						chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
						exclude = {
							filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
							buftype = { "nofile", "terminal", "help" },
						},
					},
					resize_window = true,
				},
				remove_file = {
					close_window = true,
				},
			},
			update_focused_file = {
				enable = true,
				update_root = false,
				ignore_list = {},
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
				show_on_open_dirs = true,
				debounce_delay = 50,
				severity = {
					min = vim.diagnostic.severity.HINT,
					max = vim.diagnostic.severity.ERROR,
				},
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
		})
	end,
}
