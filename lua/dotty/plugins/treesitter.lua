-- lua/dotty/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  -- Conditionally run the build step only on non-Windows systems.
  build = function()
    if not require("dotty.core.os").is_windows() then
      vim.cmd.TSUpdate()
    else
      -- On Windows, :TSUpdate can fail if build tools are not set up.
      -- You may need to install the MSVC C++ build tools for Visual Studio.
      -- See: https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-Installation-Guide
      print("Skipping automatic :TSUpdate on Windows. Run it manually if you have build tools installed.")
    end
  end,
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    -- import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")

    -- configure treesitter
    treesitter.setup({ -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = {
        enable = true,
      },
      -- ensure these language parsers are installed
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "prisma",
        "markdown",
        "markdown_inline",
        "svelte",
        "graphql",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "query",
        "vimdoc",
        "c",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}