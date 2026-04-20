return {
	"RRethy/vim-illuminate",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		delay = 100,
		under_cursor = true,
		min_count_to_highlight = 2,
		filetypes_denylist = {
			"dirbuf",
			"dirvish",
			"fugitive",
			"alpha",
			"lazy",
			"mason",
			"notify",
		},
	},
	config = function(_, opts)
		require("illuminate").configure(opts)

		vim.api.nvim_set_hl(0, "IlluminatedWordText", { underline = true })
		vim.api.nvim_set_hl(0, "IlluminatedWordRead", { underline = true })
		vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { underline = true })
	end,
}