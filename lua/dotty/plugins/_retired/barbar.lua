return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
    "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    -- You can add barbar options here if desired
    animation = true,
    auto_hide = false,
    tabpages = true,
    clickable = true,
    -- more options can be added as needed
  },
  config = function(_, opts)
    require("barbar").setup(opts)
    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }
    -- Tab navigation
    keymap.set("n", "<leader>t[", "<Cmd>BufferPrevious<CR>", vim.tbl_extend("force", opts, { desc = "Go to previous tab" }))
    keymap.set("n", "<leader>t]", "<Cmd>BufferNext<CR>", vim.tbl_extend("force", opts, { desc = "Go to next tab" }))
    -- Close tabs
    keymap.set("n", "<leader>tc", "<Cmd>BufferClose<CR>", vim.tbl_extend("force", opts, { desc = "Close current tab" }))
    keymap.set("n", "<leader>ta", "<Cmd>BufferCloseAllButCurrentOrPinned<CR>|<Cmd>BufferCloseAll<CR>", vim.tbl_extend("force", opts, { desc = "Close all tabs" }))
    keymap.set("n", "<leader>to", "<Cmd>BufferCloseAllButCurrent<CR>", vim.tbl_extend("force", opts, { desc = "Close all except current tab" }))
    -- New tab
    keymap.set("n", "<leader>tt", "<Cmd>enew<CR>", vim.tbl_extend("force", opts, { desc = "New tab" }))
  end,
}