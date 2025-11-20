return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")

    -- Modern color palette with vibrant yet sophisticated colors
    local colors = {
      bg = "none",
      fg = "#c0caf5",
      yellow = "#e0af68",
      cyan = "#7dcfff",
      darkblue = "#7aa2f7",
      green = "#9ece6a",
      orange = "#ff9e64",
      violet = "#bb9af7",
      magenta = "#ff007c",
      blue = "#2ac3de",
      red = "#f7768e"
    }

    -- Beautiful mode icons
    local mode_icons = {
      n = "󰋜",
      i = "󰏫",
      v = "󰈈",
      [''] = "󰈈",
      V = "󰈈",
      c = "󰘳",
      no = "󰋜",
      s = "󰓡",
      S = "󰓡",
      [''] = "󰓡",
      ic = "󰏫",
      R = "󰑖",
      Rv = "󰑖",
      cv = "󰘳",
      ce = "󰘳",
      r = "󰏬",
      rm = "󰏬",
      ['r?'] = "󰏬",
      ['!'] = "󰘳",
      t = "󰆍",
    }

    local custom_theme = {
      normal = {
        a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
        b = { fg = colors.blue, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg }
      },
      insert = {
        a = { fg = colors.bg, bg = colors.green, gui = "bold" },
        b = { fg = colors.green, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg }
      },
      visual = {
        a = { fg = colors.bg, bg = colors.violet, gui = "bold" },
        b = { fg = colors.violet, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg }
      },
      replace = {
        a = { fg = colors.bg, bg = colors.red, gui = "bold" },
        b = { fg = colors.red, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg }
      },
      command = {
        a = { fg = colors.bg, bg = colors.yellow, gui = "bold" },
        b = { fg = colors.yellow, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg }
      },
      inactive = {
        a = { fg = colors.fg, bg = colors.bg, gui = "bold" },
        b = { fg = colors.fg, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg }
      }
    }

    -- Main configuration
    local config = {
      options = {
        theme = custom_theme,
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
        globalstatus = true,
        disabled_filetypes = { statusline = { 'alpha', 'dashboard' } },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = {
          {
            function()
              return mode_icons[vim.fn.mode()]
            end,
            padding = { left = 1, right = 1 },
          },
          {
            'mode',
            padding = { left = 1, right = 2 },
          },
        },
        lualine_b = {
          {
            'branch',
            icon = '󰘬',
            padding = { left = 2, right = 1 },
          },
          {
            'diff',
            symbols = {
              added = '󰐕 ',
              modified = '󰏫 ',
              removed = '󰍴 ',
            },
            padding = { left = 1, right = 1 },
            diff_color = {
              added = { fg = colors.green },
              modified = { fg = colors.orange },
              removed = { fg = colors.red },
            },
          },
        },
        lualine_c = {
          {
            'filename',
            path = 1,
            symbols = {
              modified = '●',
              readonly = '',
              unnamed = '[No Name]',
            }
          }
        },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = colors.orange },
            icon = '󰓻',
          },
          {
            'diagnostics',
            symbols = {
              error = '󰅚 ',
              warn = '󰀪 ',
              info = '󰋽 ',
              hint = '󰌶 ',
            },
            diagnostics_color = {
              error = { fg = colors.red },
              warn = { fg = colors.yellow },
              info = { fg = colors.cyan },
              hint = { fg = colors.violet },
            },
            padding = { left = 1, right = 1 },
          },
          { 'filetype', icon_only = true, padding = { left = 1, right = 1 } },
          { 'encoding', padding = { left = 1, right = 1 } },
          {
            'fileformat',
            symbols = {
              unix = '󰣇',
              dos = '󰨡',
              mac = '󰀶',
            },
            padding = { left = 1, right = 2 },
          },
        },
        lualine_y = {
          { 'progress', padding = { left = 1, right = 1 } },
        },
        lualine_z = {
          { 'location', padding = { left = 1, right = 1 } },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
    }

    lualine.setup(config)
  end,
}
