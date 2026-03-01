return {
	"neovim/nvim-lspconfig",
	-- Pin to version that supports Neovim 0.10 (temporary workaround)
	-- TODO: Upgrade to Neovim 0.11+ and remove this pin
	version = "^0.2.0", -- Use a version before v3.0.0 that supports 0.10
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")
		local util = require("lspconfig/util")
		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local icons = require("dotty.core.icons")
		local signs = {
			Error = icons.diagnostics.Error,
			Warn = icons.diagnostics.Warn,
			Hint = icons.diagnostics.Hint,
			Info = icons.diagnostics.Info,
		}
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		local function has_file(patterns)
			local match = vim.fs.find(patterns, { upward = true, stop = util.path.sep })
			return match[1] ~= nil
		end

		local function disable_formatting(client)
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
		end

		local configured_servers = {}

		local function setup(server_name, config)
			configured_servers[server_name] = true
			lspconfig[server_name].setup(vim.tbl_deep_extend("force", {
				capabilities = capabilities,
			}, config or {}))
		end

		-- Lua Language Server
		if lspconfig.lua_ls then
			setup("lua_ls", {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						completion = { callSnippet = "Replace" },
					},
				},
			})
		end

		-- JavaScript/TypeScript (Next.js) via vtsls
		if lspconfig.vtsls then
			setup("vtsls", {
				root_dir = util.root_pattern(
					"next.config.js",
					"next.config.ts",
					"package.json",
					"tsconfig.json",
					"jsconfig.json"
				),
				on_attach = function(client)
					disable_formatting(client)
				end,
				settings = {
					vtsls = {
						autoUseWorkspaceTsdk = true,
						experimental = { completion = { enableServerSideSuggestions = true } },
					},
					typescript = {
						format = { enable = false },
						suggest = { completeFunctionCalls = true },
					},
					javascript = {
						format = { enable = false },
						suggest = { completeFunctionCalls = true },
					},
				},
			})
		end

		-- Tailwind CSS
		if lspconfig.tailwindcss then
			setup("tailwindcss", {
				root_dir = util.root_pattern(
					"tailwind.config.js",
					"tailwind.config.ts",
					"postcss.config.js",
					"postcss.config.ts",
					"package.json"
				),
				filetypes = {
					"html",
					"css",
					"scss",
					"sass",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"svelte",
				},
				settings = {
					tailwindCSS = {
						experimental = {
							classRegex = {
								"clsx%(([^)]*)%)",
								'cn%(([^)]*)%)',
								'cva%(([^)]*)%)',
								{ "tw`([^`]*)`", "tw%(%s*['\"]([^'\"]*)['\"]%s*%)" },
							},
						},
					},
				},
			})
		end

		-- Emmet
		if lspconfig.emmet_ls then
			setup("emmet_ls", {
				filetypes = {
					"html",
					"css",
					"scss",
					"sass",
					"less",
					"javascriptreact",
					"typescriptreact",
					"svelte",
				},
			})
		end

		-- GraphQL (only when a config exists)
		if lspconfig.graphql and has_file({ ".graphqlrc", ".graphqlrc.*", "graphql.config.*" }) then
			setup("graphql", {
				filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
			})
		end

		-- Svelte
		if lspconfig.svelte then
			setup("svelte", {
				on_attach = function(client)
					vim.api.nvim_create_autocmd("BufWritePost", {
						pattern = { "*.js", "*.ts" },
						callback = function(ctx)
							client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
						end,
					})
				end,
			})
		end

		-- Fallback handler for any other installed server
		vim.schedule(function()
			local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
			if not mason_lspconfig_ok or not mason_lspconfig or not mason_lspconfig.setup_handlers then
				return
			end

			mason_lspconfig.setup_handlers({
				function(server_name)
					if configured_servers[server_name] or not lspconfig[server_name] then
						return
					end
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,
			})
		end)
	end,
}
