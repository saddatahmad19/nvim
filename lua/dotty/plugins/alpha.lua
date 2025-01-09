return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    local icons = require("dotty.core.icons")

    -- Set header (Cosmic Theme)
    dashboard.section.header.val = {
      [[=================     ===============     ===============   ========  ========]],
      [[\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //]],
      [[||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||]],
      [[|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||]],
      [[||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||]],
      [[|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||]],
      [[||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||]],
      [[|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||]],
      [[||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||]],
      [[||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||]],
      [[||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||]],
      [[||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||]],
      [[||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||]],
      [[||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||]],
      [[||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||]],
      [[||.=='    _-'                                                     `' |  /==.||]],
      [[=='    _-'                         N E O V I M                         \/   `==]],
      [[\   _-'                                                                `-_   /]],
      [[ `''                                                                      ``' ]],
    }

    -- Custom section to display total plugins managed by lazy.nvim
    local function get_plugin_count()
      local stats = require("lazy").stats()
      return "󱐌 " .. stats.count .. " plugins loaded"
    end

    -- Footer with plugin stats
    dashboard.section.footer.val = get_plugin_count()
    dashboard.section.footer.opts.hl = "AlphaFooter"

    -- Set menu (using only keymaps from PR diff)
    dashboard.section.buttons.val = {
      dashboard.button("e", "  New File", "<cmd>ene<CR>"),
      dashboard.button("ff", "  Find File", "<cmd>Telescope find_files<CR>"),
      dashboard.button("fm", "  Bookmarks", "<cmd>Telescope marks<CR>"),
      dashboard.button("fM", "  Man Pages", "<cmd>Telescope man_pages<CR>"),
      dashboard.button("fk", "  Keymaps", "<cmd>Telescope keymaps<CR>"),
      dashboard.button("fC", "  Commands", "<cmd>Telescope commands<CR>"),
      dashboard.button("fS", "  Git Status", "<cmd>Telescope git_status<CR>"),
      dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
    }

    -- Set header padding
    dashboard.config.layout[1].val = 8

    -- Set options
    dashboard.config.opts.noautocmd = true

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
