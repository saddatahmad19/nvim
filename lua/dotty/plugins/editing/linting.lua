return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- Helper function to check if linter is available
    local function has_linter(name)
      local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/" .. name
      return vim.fn.filereadable(mason_bin) == 1 or vim.fn.executable(name) == 1
    end

    -- Build linters list conditionally
    local linters_by_ft = {}

    -- Add eslint_d if available
    if has_linter("eslint_d") then
      linters_by_ft.javascript = { "eslint_d" }
      linters_by_ft.typescript = { "eslint_d" }
      linters_by_ft.javascriptreact = { "eslint_d" }
      linters_by_ft.typescriptreact = { "eslint_d" }
      linters_by_ft.svelte = { "eslint_d" }
    end

    -- Add Python linters if available
    if has_linter("pylint") then
      linters_by_ft.python = { "pylint" }
    end

    lint.linters_by_ft = linters_by_ft

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
