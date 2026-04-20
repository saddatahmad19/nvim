return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    local icons = require("dotty.core.icons")

    local function git_root()
      local r = vim.fn.systemlist("git rev-parse --show-toplevel 2>/dev/null")
      return vim.v.shell_error == 0 and r[1] or nil
    end

    local function git_branch()
      local r = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD 2>/dev/null")
      return vim.v.shell_error == 0 and r[1] or nil
    end

    local function file_icon(path)
      local ok, devicons = pcall(require, "nvim-web-devicons")
      if ok then
        local icon = devicons.get_icon(
          vim.fn.fnamemodify(path, ":t"),
          vim.fn.fnamemodify(path, ":e"),
          { default = true }
        )
        if icon then return icon .. " " end
      end
      return "  "
    end

    local function shorten(path)
      local short = vim.fn.fnamemodify(path, ":.")
      if #short > 40 then short = "…" .. short:sub(-39) end
      return short
    end

    local function mru_entries(max)
      local root = git_root()
      local entries = {}
      for _, path in ipairs(vim.v.oldfiles) do
        if #entries >= max then break end
        if vim.fn.filereadable(path) == 1 then
          if root == nil or vim.startswith(path, root) then
            entries[#entries + 1] = path
          end
        end
      end
      return entries
    end

    -- Header
    dashboard.section.header.val = {
      "  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ",
      "              d  o  t  t  y                    ",
      "  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ",
    }
    dashboard.section.header.opts.hl = "AlphaHeader"

    -- Buttons
    dashboard.section.buttons.val = {
      dashboard.button("e",  "  New File",   "<cmd>ene<CR>"),
      dashboard.button("ff", "  Find File",  "<cmd>ProjectFiles<CR>"),
      dashboard.button("fm", "  Bookmarks",  "<cmd>Telescope marks<CR>"),
      dashboard.button("fM", "  Man Pages",  "<cmd>Telescope man_pages<CR>"),
      dashboard.button("fk", "  Keymaps",    "<cmd>Telescope keymaps<CR>"),
      dashboard.button("fC", "  Commands",   "<cmd>Telescope commands<CR>"),
      dashboard.button("fS", "  Git Status", "<cmd>Telescope git_status<CR>"),
      dashboard.button("q",  "  Quit",       "<cmd>qa<CR>"),
    }

    -- Footer
    dashboard.section.footer.val = function()
      local stats = require("lazy").stats()
      return string.format("%s %d plugins loaded", icons.misc.lazy, stats.count)
    end
    dashboard.section.footer.opts.hl = "AlphaFooter"

    -- MRU section (re-evaluated on each redraw)
    local mru_section = {
      type = "group",
      val = function()
        local files = mru_entries(8)
        if #files == 0 then
          return {
            { type = "text", val = "  no recent files", opts = { hl = "Comment", position = "center" } },
          }
        end
        local btns = {}
        for i, path in ipairs(files) do
          btns[#btns + 1] = dashboard.button(
            tostring(i),
            file_icon(path) .. shorten(path),
            "<cmd>edit " .. vim.fn.fnameescape(path) .. "<CR>"
          )
        end
        return btns
      end,
      opts = { spacing = 1 },
    }

    local divider = {
      type = "text",
      val = "────────────────────────────────────────────",
      opts = { position = "center", hl = "AlphaDivider" },
    }

    local recent_label = {
      type = "text",
      val = function()
        local branch = git_branch()
        if branch then
          return "  recent files  ·  " .. icons.git.branch .. " " .. branch
        end
        return "  recent files"
      end,
      opts = { position = "center", hl = "AlphaLabel" },
    }

    vim.cmd([[
      highlight default AlphaHeader  guifg=#7aa2f7 guibg=NONE
      highlight default AlphaLabel   guifg=#bb9af7 guibg=NONE
      highlight default AlphaDivider guifg=#3b4261 guibg=NONE
      highlight default AlphaFooter  guifg=#565f89 guibg=NONE
    ]])

    alpha.setup({
      layout = {
        { type = "padding", val = 4 },
        dashboard.section.header,
        { type = "padding", val = 2 },
        divider,
        { type = "padding", val = 1 },
        { type = "text", val = "  quick actions", opts = { position = "center", hl = "AlphaLabel" } },
        { type = "padding", val = 1 },
        dashboard.section.buttons,
        { type = "padding", val = 1 },
        divider,
        { type = "padding", val = 1 },
        recent_label,
        { type = "padding", val = 1 },
        mru_section,
        { type = "padding", val = 1 },
        divider,
        { type = "padding", val = 1 },
        dashboard.section.footer,
      },
      opts = { margin = 5, noautocmd = true },
    })

    vim.api.nvim_create_autocmd("DirChanged", {
      pattern = "*",
      callback = function() require("alpha").redraw() end,
    })

    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
