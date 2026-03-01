return {
	"williamboman/mason.nvim",
	cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
	event = { "BufReadPre", "BufNewFile" }, -- Load when buffers are opened to ensure it's ready for lspconfig
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "󰄳",
					package_pending = "󰦖",
					package_uninstalled = "󰚌",
				},
			},
		})

		-- Configure mason-lspconfig
		mason_lspconfig.setup({
			automatic_enable = false,
			ensure_installed = {
				"vtsls",
				"tailwindcss",
				"emmet_ls",
				"lua_ls",
			},
		})

		-- Only install tools that have their runtime dependencies available
		local function is_executable(cmd)
			return vim.fn.executable(cmd) == 1
		end

		local tools_to_install = {
			"stylua",
			"prettierd",
			"typescript-language-server",
		}

		if is_executable("npm") or is_executable("node") then
			table.insert(tools_to_install, "eslint_d")
			table.insert(tools_to_install, "prettier")
		end

		if is_executable("python3") or is_executable("python") then
			table.insert(tools_to_install, "flake8")
			table.insert(tools_to_install, "pylint")
			table.insert(tools_to_install, "black")
		end

		mason_tool_installer.setup({
			ensure_installed = tools_to_install,
			automatic_installation = false,
			run_on_start = false,
		})
	end,
}
