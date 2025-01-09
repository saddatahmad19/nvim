return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  version = "*",
  opts = {
    options = {
      mode = "buffers",
      -- Style customization
      separator_style = "slant",
      indicator = {
        icon = '▎', -- Vertical bar indicator
        style = 'icon',
      },
      modified_icon = "●",
      buffer_close_icon = "",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      
      -- Buffer appearance
      tab_size = 18,
      max_name_length = 18,
      color_icons = true,
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = false,
      show_tab_indicators = true,
      enforce_regular_tabs = true,
      always_show_bufferline = true,

      -- Hover effects
      hover = {
        enabled = true,
        delay = 100,
        reveal = {'close'}
      },

      -- Offsets for sidebar
      offsets = {
        {
          filetype = "NvimTree",
          text = "󰙅 Files",
          text_align = "left",
          separator = true,
        }
      },
    },
    highlights = {
      fill = {
        fg = { attribute = "fg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "StatusLineNC" },
      },
      background = {
        fg = { attribute = "fg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "StatusLine" },
      },
      buffer_visible = {
        fg = { attribute = "fg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "Normal" },
      },
      buffer_selected = {
        fg = { attribute = "fg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "Normal" },
        bold = true,
        italic = true,
      },
      separator = {
        fg = { attribute = "bg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "StatusLine" },
      },
      separator_selected = {
        fg = { attribute = "fg", highlight = "Special" },
        bg = { attribute = "bg", highlight = "Normal" },
      },
      separator_visible = {
        fg = { attribute = "fg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "StatusLineNC" },
      },
      close_button = {
        fg = { attribute = "fg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "StatusLine" },
      },
      close_button_selected = {
        fg = { attribute = "fg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "Normal" },
      },
      modified = {
        fg = { attribute = "fg", highlight = "String" },
      },
      modified_selected = {
        fg = { attribute = "fg", highlight = "String" },
      },
      modified_visible = {
        fg = { attribute = "fg", highlight = "String" },
      },
      indicator_selected = {
        fg = { attribute = "fg", highlight = "Type" },
        bg = { attribute = "bg", highlight = "Normal" },
      },
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
    -- Essential keymaps
    vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
    vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
  end,
}
