-- Themery.nvim: Colorscheme picker with live preview and persistence
-- Keybindings: <leader>zo = open picker, <leader>zn = next theme, <leader>zp = prev theme

local kanagawa_setup = function()
  require("kanagawa").setup({
    compile = false,
    undercurl = true,
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = true,
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
          ui = { bg_gutter = "none" },
        },
      },
    },
    overrides = function(colors)
      return {
        Normal = { bg = "none" },
        NormalNC = { bg = "none" },
        NormalFloat = { bg = "none" },
        FloatBorder = { fg = colors.palette.sumiInk4, bg = "none" },
        TelescopeNormal = { bg = "none" },
        TelescopeBorder = { fg = colors.palette.sumiInk4, bg = "none" },
        TelescopePromptBorder = { fg = colors.palette.sumiInk4, bg = "none" },
        TelescopeResultsBorder = { fg = colors.palette.sumiInk4, bg = "none" },
        TelescopePreviewBorder = { fg = colors.palette.sumiInk4, bg = "none" },
        SignColumn = { bg = "none" },
        LineNr = { bg = "none" },
        CursorLineNr = { bg = "none" },
        FoldColumn = { bg = "none" },
        EndOfBuffer = { bg = "none" },
      }
    end,
  })
end

local theme_plugins = {
  "rebelot/kanagawa.nvim",
  "catppuccin/nvim",
  "folke/tokyonight.nvim",
  "ellisonleao/gruvbox.nvim",
  "Mofiqul/dracula.nvim",
  "shaunsingh/nord.nvim",
  "sainnhe/everforest",
  "sainnhe/edge",
  "rose-pine/neovim",
  "savq/melange-nvim",
  "sainnhe/gruvbox-material",
  "loctvl842/monokai-pro.nvim",
  "tanvirtin/monokai.nvim",
  "water-sucks/darkrose.nvim",
  "scottmckendry/cyberdream.nvim",
}

return {
  -- Themery plugin
  {
    "zaldih/themery.nvim",
    cmd = { "Themery", "ThemeryList" },
    priority = 1001,
    dependencies = theme_plugins,
    config = function()
      require("themery").setup({
        themes = {
          -- Kanagawa variants (setup runs on plugin load)
          { name = "Kanagawa Wave", colorscheme = "kanagawa-wave" },
          { name = "Kanagawa Dragon", colorscheme = "kanagawa-dragon" },
          { name = "Kanagawa Lotus", colorscheme = "kanagawa-lotus" },

          -- Catppuccin (Frappe, Mocha, Latte, Macchiato - coffee flavors)
          { name = "Catppuccin Mocha", colorscheme = "catppuccin-mocha" },
          { name = "Catppuccin Frappe", colorscheme = "catppuccin-frappe" },
          { name = "Catppuccin Latte", colorscheme = "catppuccin-latte" },
          { name = "Catppuccin Macchiato", colorscheme = "catppuccin-macchiato" },

          -- Tokyo Night
          { name = "Tokyo Night", colorscheme = "tokyonight" },
          { name = "Tokyo Night Storm", colorscheme = "tokyonight-storm" },
          { name = "Tokyo Night Day", colorscheme = "tokyonight-day" },
          { name = "Tokyo Night Moon", colorscheme = "tokyonight-moon" },

          -- Gruvbox (needs background)
          { name = "Gruvbox Dark", colorscheme = "gruvbox", before = [[ vim.o.background = "dark" ]] },
          { name = "Gruvbox Light", colorscheme = "gruvbox", before = [[ vim.o.background = "light" ]] },

          -- Other popular themes
          { name = "Dracula", colorscheme = "dracula" },
          { name = "Nord", colorscheme = "nord" },
          { name = "Everforest Dark", colorscheme = "everforest", before = [[ vim.o.background = "dark" ]] },
          { name = "Everforest Light", colorscheme = "everforest", before = [[ vim.o.background = "light" ]] },
          { name = "Edge Dark", colorscheme = "edge", before = [[ vim.o.background = "dark" ]] },
          { name = "Edge Light", colorscheme = "edge", before = [[ vim.o.background = "light" ]] },
          { name = "Rose Pine", colorscheme = "rose-pine" },
          { name = "Rose Pine Moon", colorscheme = "rose-pine-moon" },
          { name = "Rose Pine Dawn", colorscheme = "rose-pine-dawn" },
          { name = "Melange", colorscheme = "melange" },
          { name = "Gruvbox Material Dark", colorscheme = "gruvbox-material", before = [[ vim.o.background = "dark" ]] },
          { name = "Gruvbox Material Light", colorscheme = "gruvbox-material", before = [[ vim.o.background = "light" ]] },
          { name = "Monokai Pro", colorscheme = "monokai-pro" },
          { name = "Monokai", colorscheme = "monokai" },

          -- Dark red & cyberpunk
          { name = "Darkrose", colorscheme = "darkrose" },
          { name = "Cyberdream", colorscheme = "cyberdream" },
        },
        livePreview = true,
      })
      -- Keybindings: <leader>zo, <leader>zn, <leader>zp are set in which_key.lua
    end,
  },

  -- Kanagawa
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    lazy = false,
    config = kanagawa_setup,
  },

  -- Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
        term_colors = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          treesitter = true,
          telescope = true,
          harpoon = true,
          which_key = true,
        },
      })
    end,
  },

  -- Tokyo Night
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = false,
        terminal_colors = true,
      })
    end,
  },

  -- Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    lazy = false,
  },

  -- Dracula
  {
    "Mofiqul/dracula.nvim",
    priority = 1000,
    lazy = false,
  },

  -- Nord
  {
    "shaunsingh/nord.nvim",
    priority = 1000,
    lazy = false,
  },

  -- Everforest
  {
    "sainnhe/everforest",
    priority = 1000,
    lazy = false,
    config = function()
      vim.g.everforest_better_performance = 1
    end,
  },

  -- Edge
  {
    "sainnhe/edge",
    priority = 1000,
    lazy = false,
  },

  -- Rose Pine
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    lazy = false,
    config = function()
      require("rose-pine").setup({
        variant = "main",
        dark_variant = "main",
        dim_inactive_windows = false,
        extend_background_behind_borders = true,
      })
    end,
  },

  -- Melange
  {
    "savq/melange-nvim",
    priority = 1000,
    lazy = false,
  },

  -- Gruvbox Material
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    lazy = false,
  },

  -- Monokai Pro
  {
    "loctvl842/monokai-pro.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("monokai-pro").setup({
        filter = "pro",
        background_clear = {},
      })
    end,
  },

  -- Monokai (fallback)
  {
    "tanvirtin/monokai.nvim",
    priority = 1000,
    lazy = false,
  },

  -- Darkrose: dark theme with rose/red tones
  {
    "water-sucks/darkrose.nvim",
    priority = 1000,
    lazy = false,
  },

  -- Cyberdream: cyberpunk, high-contrast, futuristic
  {
    "scottmckendry/cyberdream.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("cyberdream").setup({
        transparent = false,
        italic_comments = false,
        terminal_colors = true,
      })
    end,
  },
}
