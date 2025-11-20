return {
	"prichrd/netrw.nvim",
	config = function()
		require("netrw").setup({
			-- Global configuration that will be used for all buffers
			icons = {
				symlink = "",
				directory = "",
				file = "",
			},
			use_devicons = true,
			-- mappings = {
			--     ["u"] = function()
			--         return require("netrw").navigate_up()
			--     end,
			--     ["."] = function()
			--         return require("netrw").toggle_hidden()
			--     end,
			--     ["n"] = function()
			--         return require("netrw").create()
			--     end,
			--     ["d"] = function()
			--         return require("netrw").create_dir()
			--     end,
			--     ["D"] = function()
			--         return require("netrw").delete()
			--     end,
			--     ["r"] = function()
			--         return require("netrw").rename()
			--     end,
			-- },
		})
	end,
}

