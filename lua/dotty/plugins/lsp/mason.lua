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
		-- Note: We don't use ensure_installed here to avoid automatic_enable conflicts
		-- Servers will be installed manually via :Mason or automatically when needed
		-- The setup_handlers in lspconfig.lua will handle server configuration
		mason_lspconfig.setup({
			-- Leave ensure_installed empty to avoid automatic_enable issues
			-- You can install servers manually via :Mason command
			-- Or they will be installed automatically when lspconfig tries to use them
			-- Disable mason-lspconfig's automatic_enable feature (requires Neovim 0.10+)
			automatic_enable = false,
		})

	-- Only install tools that have their runtime dependencies available
	local function is_executable(cmd)
		return vim.fn.executable(cmd) == 1
	end

	local tools_to_install = {
		"stylua", -- Lua formatter (no external deps)
	}

	-- Conditionally add tools based on available runtimes
	if is_executable("npm") or is_executable("node") then
		table.insert(tools_to_install, "prettier")
		table.insert(tools_to_install, "eslint_d")
	end

	if is_executable("python3") or is_executable("python") then
		table.insert(tools_to_install, "flake8")
		table.insert(tools_to_install, "pylint")
		table.insert(tools_to_install, "black")
	end

	-- Configure mason-tool-installer
	-- Disable automatic installation to prevent errors on startup
	-- Tools can be installed manually via :Mason command when needed
	mason_tool_installer.setup({
		ensure_installed = tools_to_install,
		-- Disable automatic installation to prevent startup errors
		-- Install tools manually via :Mason command or set to true if you want auto-install
		automatic_installation = false,
		-- Run check on startup to verify installed tools
		run_on_start = false,
	})
	end,
}
