return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			end,
		})

		-- Set capabilities globally for all servers
		local capabilities = cmp_nvim_lsp.default_capabilities()
		vim.lsp.config("*", { capabilities = capabilities })

		-- Diagnostic signs
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
			return vim.fs.find(patterns, { upward = true })[1] ~= nil
		end

		local function disable_formatting(client)
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
		end

		-- Lua Language Server
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					completion = { callSnippet = "Replace" },
				},
			},
		})

		-- JavaScript/TypeScript (Next.js) via vtsls
		vim.lsp.config("vtsls", {
			root_dir = function(bufnr, on_dir)
				local fname = vim.api.nvim_buf_get_name(bufnr)
				local dir = vim.fs.root(fname, {
					"next.config.js",
					"next.config.ts",
					"package.json",
					"tsconfig.json",
					"jsconfig.json",
				})
				if dir then on_dir(dir) end
			end,
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

		-- Tailwind CSS
		vim.lsp.config("tailwindcss", {
			root_dir = function(bufnr, on_dir)
				local fname = vim.api.nvim_buf_get_name(bufnr)
				local dir = vim.fs.root(fname, {
					"tailwind.config.js",
					"tailwind.config.ts",
					"postcss.config.js",
					"postcss.config.ts",
					"package.json",
				})
				if dir then on_dir(dir) end
			end,
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

		-- Emmet
		vim.lsp.config("emmet_ls", {
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

		-- Svelte
		vim.lsp.config("svelte", {
			on_attach = function(client)
				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.js", "*.ts" },
					callback = function(ctx)
						client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
					end,
				})
			end,
		})

		local explicitly_configured = {
			lua_ls = true,
			vtsls = true,
			tailwindcss = true,
			emmet_ls = true,
			svelte = true,
		}

		-- GraphQL (only when a config exists in the project)
		if has_file({ ".graphqlrc", ".graphqlrc.*", "graphql.config.*" }) then
			vim.lsp.config("graphql", {
				filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
			})
			explicitly_configured.graphql = true
		end

		vim.lsp.enable(vim.tbl_keys(explicitly_configured))

		-- Fallback: enable any mason-installed server not explicitly configured
		vim.schedule(function()
			local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
			if not ok or not mason_lspconfig.setup_handlers then return end

			mason_lspconfig.setup_handlers({
				function(server_name)
					if not explicitly_configured[server_name] then
						vim.lsp.enable(server_name)
					end
				end,
			})
		end)
	end,
}
