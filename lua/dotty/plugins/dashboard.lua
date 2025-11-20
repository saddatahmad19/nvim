return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    -- Only show dashboard if no file arguments were passed
    if vim.fn.argc() > 0 then
      return
    end

    -- Handle modified buffers before dashboard tries to open
    -- Run with high priority to ensure it executes before dashboard loads
    vim.api.nvim_create_autocmd("VimEnter", {
      once = true,
      callback = function()
        -- Immediately clean up any unnamed modified buffers
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_valid(buf) then
            local bufname = vim.api.nvim_buf_get_name(buf)
            -- If buffer is modified and unnamed (empty buffer), discard changes
            if vim.bo[buf].modified and bufname == "" and vim.bo[buf].buftype == "" then
              vim.bo[buf].modified = false
            end
          end
        end
      end,
    })
  end,
  config = function()
    local dashboard = require("dashboard")
    local utils = require("dashboard.utils")

    local header = {
      " ██████╗  ██████╗ ████████╗████████╗██╗   ██╗██╗   ██╗",
      "██╔═══██╗██╔═══██╗╚══██╔══╝╚══██╔══╝╚██╗ ██╔╝╚██╗ ██╔╝",
      "██║   ██║██║   ██║   ██║      ██║     ╚████╔╝  ╚████╔╝ ",
      "██║   ██║██║   ██║   ██║      ██║      ╚██╔╝    ╚██╔╝  ",
      "╚██████╔╝╚██████╔╝   ██║      ██║       ██║      ██║   ",
      " ╚═════╝  ╚═════╝    ╚═╝      ╚═╝       ╚═╝      ╚═╝   ",
      "                  ✺    N E O V I M    ✺                  ",
    }

    local function footer()
      local stats = require("lazy").stats()
      local time = os.date("%H:%M")
      return string.format("󱐌 %d plugins •  %s", stats.count, time)
    end

    -- Shortcuts as text reminders only (not clickable/enterable)
    local shortcuts = {
      {
        icon = "  ",
        desc = "Find files",
        group = "DashboardShortCut",
        keybinding = "ff", -- Actual keybinding: <leader>ff
      },
      {
        icon = "󰚰  ",
        desc = "Recent files",
        group = "DashboardShortCut",
        keybinding = "fr", -- Actual keybinding: <leader>fr
      },
      {
        icon = "󰕰  ",
        desc = "Buffers",
        group = "DashboardShortCut",
        keybinding = "fb", -- Actual keybinding: <leader>fb
      },
      {
        icon = "󰌌  ",
        desc = "Keymaps",
        group = "DashboardShortCut",
        keybinding = "fk", -- Actual keybinding: <leader>fk
      },
      {
        icon = "󰒲  ",
        desc = "Plugin updates",
        group = "DashboardShortCut",
        keybinding = "fu", -- Actual keybinding: <leader>fu
      },
      {
        icon = "󰩈  ",
        desc = "Quit",
        group = "DashboardShortCut",
        keybinding = "q", -- Actual keybinding: <leader>q
      },
    }

    local function stack_shortcuts_vertically(bufnr)
      if not vim.api.nvim_buf_is_valid(bufnr) or vim.tbl_isempty(shortcuts) then
        return
      end

      -- Find a good position to insert shortcuts (after header, before projects)
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      local target = nil
      
      -- Try to find the project section or use a default position
      for idx, line in ipairs(lines) do
        if line:match("Recent Projects") or line:match("Projects") then
          target = idx - 3 -- Insert a few lines before projects
          break
        end
      end
      
      -- If no project section found, insert after header (around line 10-15)
      if not target then
        target = math.min(15, #lines - 1)
      end

      local stacked = { "", "󰌌  Shortcuts", "" }
      for _, item in ipairs(shortcuts) do
        local keybinding = item.keybinding and ("[" .. item.keybinding .. "]") or ""
        local icon = item.icon or ""
        table.insert(stacked, string.format(" %s %s%s", keybinding, icon, item.desc))
      end
      table.insert(stacked, "")
      stacked = utils.center_align(stacked)

      local was_modifiable = vim.bo[bufnr].modifiable
      if not was_modifiable then
        vim.bo[bufnr].modifiable = true
      end

      -- Insert the shortcuts at the target position
      vim.api.nvim_buf_set_lines(bufnr, target, target, false, stacked)

      -- Apply highlighting to the inserted lines
      for i, line in ipairs(stacked) do
        if line:match("%S") then
          local line_num = target + i - 1
          if line_num >= 0 then
            vim.api.nvim_buf_add_highlight(bufnr, 0, "DashboardShortCut", line_num, 0, -1)
          end
        end
      end

      if not was_modifiable then
        vim.bo[bufnr].modifiable = false
      end
    end

    dashboard.setup({
      theme = "hyper",
      disable_move = true,
      shortcut_type = "letter",
      change_to_vcs_root = true,
      config = {
        header = header,
        -- Don't include shortcuts in config - we'll add them manually as text-only
        project = {
          enable = true,
          limit = 5,
          icon = "󰏓 ",
          label = " Recent Projects:",
          action = "Telescope find_files cwd=",
        },
        mru = { enable = false },
        footer = { footer() },
      },
      hide = {
        statusline = true,
        tabline = true,
        winbar = true,
      },
    })

    if not vim.g.dotty_dashboard_shortcuts_autocmd then
      vim.api.nvim_create_autocmd("User", {
        pattern = "DashboardLoaded",
        callback = function(args)
          if args.buf then
            stack_shortcuts_vertically(args.buf)
          end
        end,
      })
      vim.g.dotty_dashboard_shortcuts_autocmd = true
    end

    vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#f7768e", bg = "NONE", bold = true })
    vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#565f89", bg = "NONE" })
    vim.api.nvim_set_hl(0, "DashboardShortCut", { fg = "#c0caf5", bg = "NONE", bold = true })
  end,
}

