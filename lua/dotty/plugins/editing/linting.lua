return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    local function has_linter(name)
      local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/" .. name
      return vim.fn.filereadable(mason_bin) == 1 or vim.fn.executable(name) == 1
    end

    local function has_eslint_config(bufnr)
      local file = vim.api.nvim_buf_get_name(bufnr)
      local root = vim.fs.root(file, {
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.mjs",
        ".eslintrc.json",
        ".eslintrc.yaml",
        ".eslintrc.yml",
        "eslint.config.js",
        "eslint.config.mjs",
        "eslint.config.cjs",
      })
      if root then
        return true
      end

      local pkg = vim.fs.find("package.json", { upward = true, path = file })[1]
      if pkg then
        local ok, decoded = pcall(vim.fn.json_decode, table.concat(vim.fn.readfile(pkg), "\n"))
        if ok and decoded and decoded.eslintConfig then
          return true
        end
      end

      return false
    end

    local linters_by_ft = {}

    if has_linter("eslint_d") then
      linters_by_ft.javascript = { "eslint_d" }
      linters_by_ft.typescript = { "eslint_d" }
      linters_by_ft.javascriptreact = { "eslint_d" }
      linters_by_ft.typescriptreact = { "eslint_d" }
      linters_by_ft.svelte = { "eslint_d" }
    end

    if has_linter("pylint") then
      linters_by_ft.python = { "pylint" }
    end

    lint.linters_by_ft = linters_by_ft

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        local is_js_ft = ft == "javascript" or ft == "typescript" or ft == "javascriptreact" or ft == "typescriptreact" or ft == "svelte"
        if is_js_ft and not has_eslint_config(args.buf) then
          return
        end
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
