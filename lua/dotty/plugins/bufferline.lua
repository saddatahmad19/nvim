return {
  "akinsho/bufferline.nvim",
  dependencies = { 
    "nvim-tree/nvim-web-devicons",
    "tiagovla/scope.nvim",
  },
  event = "VeryLazy",
  version = "*",
  opts = {
    options = {
      mode = "buffers",
      themable = true,
      numbers = "ordinal",
      close_command = function(n) require("mini.bufremove").delete(n, false) end,
      right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
      left_mouse_command = "buffer %d",
      middle_mouse_command = nil,
      indicator = {
        icon = "▎",
        style = "icon",
      },
      buffer_close_icon = "󰅖",
      modified_icon = "●",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      max_name_length = 30,
      max_prefix_length = 30,
      truncate_names = true,
      tab_size = 21,
      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = false,
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or level:match("warning") and " " or ""
        return " " .. icon .. count
      end,
      custom_filter = function(buf_number, buf_numbers)
        -- filter out filetypes you don't want to see
        local exclude_ft = { "qf", "fugitive", "git" }
        local cur_ft = vim.bo[buf_number].filetype
        local should_filter = vim.tbl_contains(exclude_ft, cur_ft)
        if should_filter then
          return false
        end
        return true
      end,
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "center",
          separator = true,
        },
      },
      color_icons = true,
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = false,
      show_tab_indicators = true,
      show_duplicate_prefix = true,
      persist_buffer_sort = true,
      separator_style = "thin",
      enforce_regular_tabs = false,
      always_show_bufferline = true,
      hover = {
        enabled = true,
        delay = 200,
        reveal = {'close'}
      },
      sort_by = 'insert_after_current',
      groups = {
        options = {
          toggle_hidden_on_enter = true
        },
        items = {
          {
            name = "Tests",
            icon = "󰙨",
            highlight = {gui = "underline"},
            priority = 2,
            auto_close = true,
            matcher = function(buf)
              local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf.id), ':t')
              return name:match('%_test') or name:match('%_spec')
            end,
          },
          {
            name = "Docs",
            icon = "󰈙",
            highlight = {gui = "undercurl"},
            priority = 3,
            auto_close = false,
            matcher = function(buf)
              local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf.id), ':t')
              return name:match('%.md') or name:match('%.txt')
            end,
          },
        }
      },
    },
    highlights = {
      background = {
        italic = true,
      },
      buffer_selected = {
        bold = true,
      },
      diagnostic_selected = {
        bold = true,
      },
      info_selected = {
        bold = true,
      },
      info_diagnostic_selected = {
        bold = true,
      },
      warning_selected = {
        bold = true,
      },
      warning_diagnostic_selected = {
        bold = true,
      },
      error_selected = {
        bold = true,
      },
      error_diagnostic_selected = {
        bold = true,
      },
      duplicate_selected = {
        italic = true,
      },
      duplicate_visible = {
        italic = true,
      },
      duplicate = {
        italic = true,
      },
      pick_selected = {
        bold = true,
        italic = true,
      },
      pick_visible = {
        bold = true,
        italic = true,
      },
      pick = {
        bold = true,
        italic = true,
      },
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
    -- Load scope for better tab integration
    require("scope").setup()
    
    -- Add some useful keymaps for buffer navigation
    vim.keymap.set("n", "<leader>bp", ":BufferLineTogglePin<CR>", { desc = "Toggle pin" })
    vim.keymap.set("n", "<leader>bP", ":BufferLineGroupClose ungrouped<CR>", { desc = "Delete non-pinned buffers" })
    vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
    vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
    vim.keymap.set("n", "[b", ":BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
    vim.keymap.set("n", "]b", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
    vim.keymap.set("n", "<leader>b1", ":BufferLineGoToBuffer 1<CR>", { desc = "Go to buffer 1" })
    vim.keymap.set("n", "<leader>b2", ":BufferLineGoToBuffer 2<CR>", { desc = "Go to buffer 2" })
    vim.keymap.set("n", "<leader>b3", ":BufferLineGoToBuffer 3<CR>", { desc = "Go to buffer 3" })
    vim.keymap.set("n", "<leader>b4", ":BufferLineGoToBuffer 4<CR>", { desc = "Go to buffer 4" })
    vim.keymap.set("n", "<leader>b5", ":BufferLineGoToBuffer 5<CR>", { desc = "Go to buffer 5" })
  end,
}
