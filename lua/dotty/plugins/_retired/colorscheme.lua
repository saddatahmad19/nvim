return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "storm",
        transparent = false,
        styles = {
          sidebars = "dark",
          floats = "dark",
        },
        on_colors = function(colors)
          colors.bg = "#1a1b26"
          colors.bg_dark = "#16161e"
          colors.bg_float = "#16161e"
          colors.bg_highlight = "#292e42"
          colors.bg_popup = "#16161e"
          colors.bg_search = "#3d59a1"
          colors.bg_visual = "#2e3c64"
          colors.border = "#7aa2f7"
          colors.terminal_black = "#414868"
          colors.fg = "#c0caf5"
          colors.fg_dark = "#a9b1d6"
          colors.fg_gutter = "#3b4261"
          colors.fg_sidebar = "#a9b1d6"
          colors.comment = "#565f89"
          colors.blue = "#7aa2f7"
          colors.cyan = "#7dcfff"
          colors.blue1 = "#2ac3de"
          colors.blue2 = "#0db9d7"
          colors.blue5 = "#89ddff"
          colors.blue6 = "#b4f9f8"
          colors.magenta = "#bb9af7"
          colors.magenta2 = "#ff007c"
          colors.purple = "#9d7cd8"
          colors.orange = "#ff9e64"
          colors.yellow = "#e0af68"
          colors.green = "#9ece6a"
          colors.green1 = "#73daca"
          colors.green2 = "#41a6b5"
          colors.teal = "#1abc9c"
          colors.red = "#f7768e"
          colors.red1 = "#db4b4b"
        end,
        on_highlights = function(hl, c)
          hl.CursorLine = { bg = "#1f2335" }
          hl.LineNr = { fg = "#3b4261" }
          hl.CursorLineNr = { fg = "#737aa2" }
        end,
      })

      -- Set Tokyo Night as the default theme
      vim.cmd.colorscheme("tokyonight-storm")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false,
        term_colors = true,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = { "bold" },
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        color_overrides = {
          mocha = {
            rosewater = "#f5e0dc",
            flamingo = "#f2cdcd",
            pink = "#f5c2e7",
            mauve = "#cba6f7",
            red = "#f38ba8",
            maroon = "#eba0ac",
            peach = "#fab387",
            yellow = "#f9e2af",
            green = "#a6e3a1",
            teal = "#94e2d5",
            sky = "#89dceb",
            sapphire = "#74c7ec",
            blue = "#89b4fa",
            lavender = "#b4befe",
            text = "#cdd6f4",
            subtext1 = "#bac2de",
            subtext0 = "#a6adc8",
            overlay2 = "#9399b2",
            overlay1 = "#7f849c",
            overlay0 = "#6c7086",
            surface2 = "#585b70",
            surface1 = "#45475a",
            surface0 = "#313244",
            base = "#1e1e2e",
            mantle = "#181825",
            crust = "#11111b",
          },
        },
        highlight_overrides = {
          mocha = function(colors)
            return {
              NvimTreeNormal = { bg = colors.mantle },
              CmpBorder = { fg = colors.surface2 },
            }
          end,
        },
      })

      -- To use Catppuccin, uncomment the line below and comment out the Tokyo Night colorscheme line
      -- vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true},
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,
        dimInactive = false,
        terminalColors = true,
        colors = {
          palette = {
            sumiInk0 = "#16161D",
            sumiInk1 = "#181820",
            sumiInk2 = "#1a1a22",
            sumiInk3 = "#1F1F28",
            sumiInk4 = "#2A2A37",
            sumiInk5 = "#363646",
            sumiInk6 = "#54546D",
            fujiWhite = "#DCD7BA",
            oldWhite = "#C8C093",
            springViolet1 = "#938AA9",
            springViolet2 = "#9CABCA",
            springBlue = "#7FB4CA",
            waveAqua1 = "#6A9589",
            waveAqua2 = "#7AA89F",
            waveBlue1 = "#223249",
            waveBlue2 = "#2D4F67",
            winterGreen = "#2B3328",
            winterYellow = "#49443C",
            winterRed = "#43242B",
            winterBlue = "#252535",
            autumnGreen = "#76946A",
            autumnRed = "#C34043",
            autumnYellow = "#DCA561",
            samuraiRed = "#E82424",
            roninYellow = "#FF9E3B",
            waveRed = "#E46876",
            dragonBlue = "#658594",
            dragonOrange = "#FFA066",
            fujiGray = "#727169",
            springGreen = "#98BB6C",
            oniViolet = "#957FB8",
            crystalBlue = "#7E9CD8",
            peachRed = "#FF5D62",
          },
          theme = {
            wave = {},
            lotus = {},
            dragon = {},
            all = {
              ui = {
                bg_gutter = "none"
              }
            }
          },
        },
        overrides = function(colors)
          return {
            NvimTreeNormal = { bg = colors.palette.sumiInk1 },
            TelescopeNormal = { bg = colors.palette.sumiInk0 },
            TelescopeBorder = { fg = colors.palette.sumiInk4, bg = colors.palette.sumiInk0 },
          }
        end,
      })

      -- To use Kanagawa, uncomment the line below and comment out the other colorscheme lines
      vim.cmd.colorscheme("kanagawa")
    end,
  },
}
