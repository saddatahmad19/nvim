return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    local function has_formatter(name)
      local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/" .. name
      return vim.fn.filereadable(mason_bin) == 1 or vim.fn.executable(name) == 1
    end

    local function has_prettier_config(bufnr)
      local root = vim.fs.root(bufnr, {
        ".prettierrc",
        ".prettierrc.js",
        ".prettierrc.cjs",
        ".prettierrc.mjs",
        ".prettierrc.json",
        ".prettierrc.yaml",
        ".prettierrc.yml",
        "prettier.config.js",
        "prettier.config.cjs",
        "prettier.config.mjs",
      })
      if root then
        return true
      end

      local pkg = vim.fs.find("package.json", { upward = true, path = vim.api.nvim_buf_get_name(bufnr) })[1]
      if pkg then
        local ok, decoded = pcall(vim.fn.json_decode, table.concat(vim.fn.readfile(pkg), "\n"))
        if ok and decoded and decoded.prettier then
          return true
        end
      end

      return false
    end

    local formatters_by_ft = {
      lua = { "stylua" },
    }

    -- Check for prettier/prettierd and add formatters
    local prettier_found = false
    if has_formatter("prettierd") then
      formatters_by_ft.javascript = { "prettierd" }
      formatters_by_ft.typescript = { "prettierd" }
      formatters_by_ft.javascriptreact = { "prettierd" }
      formatters_by_ft.typescriptreact = { "prettierd" }
      formatters_by_ft.svelte = { "prettierd" }
      formatters_by_ft.css = { "prettierd" }
      formatters_by_ft.html = { "prettierd" }
      formatters_by_ft.json = { "prettierd" }
      formatters_by_ft.yaml = { "prettierd" }
      formatters_by_ft.markdown = { "prettierd" }
      formatters_by_ft.graphql = { "prettierd" }
      formatters_by_ft.liquid = { "prettierd" }
      prettier_found = true
    elseif has_formatter("prettier") then
      formatters_by_ft.javascript = { "prettier" }
      formatters_by_ft.typescript = { "prettier" }
      formatters_by_ft.javascriptreact = { "prettier" }
      formatters_by_ft.typescriptreact = { "prettier" }
      formatters_by_ft.svelte = { "prettier" }
      formatters_by_ft.css = { "prettier" }
      formatters_by_ft.html = { "prettier" }
      formatters_by_ft.json = { "prettier" }
      formatters_by_ft.yaml = { "prettier" }
      formatters_by_ft.markdown = { "prettier" }
      formatters_by_ft.graphql = { "prettier" }
      formatters_by_ft.liquid = { "prettier" }
      prettier_found = true
    end

    -- If prettier not found, LSP fallback will be used
    if not prettier_found then
      vim.notify("Prettier/prettierd not found. Using LSP formatter as fallback.", vim.log.levels.INFO)
    end

    if has_formatter("black") then
      formatters_by_ft.python = { "black" }
      if has_formatter("isort") then
        formatters_by_ft.python = { "isort", "black" }
      end
    end

    conform.setup({
      formatters_by_ft = formatters_by_ft,
      format_on_save = function(bufnr)
        -- Always format on save, even without prettier config
        -- Prettier will use its defaults if no config is found
        return {
          lsp_fallback = true,
          async = false,
          timeout_ms = 2000,
        }
      end,
    })

    -- Manual format keymap with error handling
    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      local bufnr = vim.api.nvim_get_current_buf()
      local ok, err = pcall(function()
        conform.format({
          bufnr = bufnr,
          lsp_fallback = true,
          async = false,
          timeout_ms = 2000,
        })
      end)
      if not ok then
        vim.notify("Formatting failed: " .. tostring(err), vim.log.levels.ERROR)
      end
    end, { desc = "Format file or range (in visual mode)" })

    -- Diagnostic command to check formatter status
    vim.api.nvim_create_user_command("ConformInfo", function()
      local bufnr = vim.api.nvim_get_current_buf()
      local ft = vim.bo[bufnr].filetype
      local formatters = conform.list_formatters(bufnr)
      
      local msg = string.format("Filetype: %s\nFormatters: %s", ft, vim.inspect(formatters))
      vim.notify(msg, vim.log.levels.INFO)
      print("\n=== Conform.nvim Status ===")
      print("Filetype: " .. ft)
      print("Available formatters:")
      for _, formatter in ipairs(formatters) do
        print("  - " .. formatter.name .. (formatter.available and " (available)" or " (not available)"))
      end
    end, { desc = "Show formatter information for current buffer" })
  end,
}
