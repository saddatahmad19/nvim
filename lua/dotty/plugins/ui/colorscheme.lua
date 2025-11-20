return {
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("kanagawa").setup({
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
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
            TelescopeNormal = { bg = colors.palette.sumiInk0 },
            TelescopeBorder = { fg = colors.palette.sumiInk4, bg = colors.palette.sumiInk0 },
          }
        end,
      })

      vim.cmd.colorscheme("kanagawa")
    end,
  },
}

