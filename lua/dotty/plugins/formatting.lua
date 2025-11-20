return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    -- Helper function to check if formatter is available
    local function has_formatter(name)
      local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/" .. name
      return vim.fn.filereadable(mason_bin) == 1 or vim.fn.executable(name) == 1
    end

    -- Build formatters list conditionally
    local formatters_by_ft = {
      lua = { "stylua" }, -- Always available, no external deps
    }

    -- Add prettier-based formatters if prettier is available
    if has_formatter("prettier") then
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
    end

    -- Add Python formatters if available
    if has_formatter("black") then
      formatters_by_ft.python = { "black" }
      -- Add isort if available
      if has_formatter("isort") then
        formatters_by_ft.python = { "isort", "black" }
      end
    end

    conform.setup({
      formatters_by_ft = formatters_by_ft,
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
