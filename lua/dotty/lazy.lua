local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "dotty.plugins.core" },
  { import = "dotty.plugins.ui" },
  { import = "dotty.plugins.navigation" },
  { import = "dotty.plugins.editing" },
  { import = "dotty.plugins.git" },
  { import = "dotty.plugins.tools" },
  { import = "dotty.plugins.treesitter" },
  { import = "dotty.plugins.lsp" },
}, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
