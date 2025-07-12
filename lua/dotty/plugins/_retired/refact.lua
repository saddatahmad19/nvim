return {
	"smallcloudai/refact-neovim",
	lazy = false,
	config = function()
		require("refact-neovim").setup({
			address_url = "Refact",
			api_key = "1DSkt256GRqBCUasDJ27dUhY",
		})
	end,
}
