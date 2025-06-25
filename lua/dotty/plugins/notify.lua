return {
  "rcarriga/nvim-notify",
  config = function()
    local notify = require("notify")
    
    -- Custom notification styles with techno-cool appearance
    local function setup_notify_styles()
      -- Define custom notification styles
      notify.setup({
        background_colour = "NONE",
        fps = 60,
        icons = {
          DEBUG = "",
          ERROR = "",
          INFO = "",
          TRACE = "",
          WARN = "",
        },
        level = 2,
        minimum_width = 50,
        render = "default",
        stages = "fade_in_slide_out",
        timeout = 5000,
        top_down = true,
        max_width = function()
          return math.floor(vim.o.columns * 0.7)
        end,
        max_height = function()
          return math.floor(vim.o.lines * 0.7)
        end,
        on_open = function(win)
          vim.api.nvim_win_set_config(win, { zindex = 100 })
        end,
        on_close = function(win)
          vim.api.nvim_win_close(win, true)
        end,
        -- Custom render function for techno-cool appearance
        render = function(bufnr, notif, highlights)
          local buf = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
          local icon = notif.icon or ""
          local title = notif.title[1] or ""
          local message = notif.message or ""
          
          -- Handle message format - convert table to string if needed
          if type(message) == "table" then
            message = table.concat(message, "\n")
          end
          
          -- Create techno-cool border and styling
          local lines = {}
          local highlights_list = {}
          
          -- Top border with techno pattern
          table.insert(lines, "╭─" .. string.rep("─", #title + #icon + 4) .. "─╮")
          table.insert(highlights_list, { "NotifyBorder", 0, 0, -1 })
          
          -- Title line with icon
          table.insert(lines, "│ " .. icon .. " " .. title .. " │")
          table.insert(highlights_list, { "NotifyTitle", 1, 2, 2 + #icon })
          table.insert(highlights_list, { "NotifyTitle", 1, 3 + #icon, -2 })
          
          -- Message lines
          local wrapped_message = vim.split(message, "\n")
          for i, line in ipairs(wrapped_message) do
            if i == 1 then
              table.insert(lines, "│ " .. line .. string.rep(" ", #title + #icon + 2 - #line) .. " │")
            else
              table.insert(lines, "│ " .. line .. string.rep(" ", #title + #icon + 2 - #line) .. " │")
            end
            table.insert(highlights_list, { "NotifyBody", #lines, 2, -2 })
          end
          
          -- Bottom border
          table.insert(lines, "╰─" .. string.rep("─", #title + #icon + 4) .. "─╯")
          table.insert(highlights_list, { "NotifyBorder", #lines, 0, -1 })
          
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
          
          -- Apply highlights
          for _, hl in ipairs(highlights_list) do
            vim.api.nvim_buf_add_highlight(bufnr, -1, hl[1], hl[2], hl[3], hl[4])
          end
        end,
      })
    end
    
    setup_notify_styles()
    
    -- Replace vim.notify with our enhanced version
    vim.notify = notify
    
    -- Create custom notification functions
    local function notify_success(msg, opts)
      opts = opts or {}
      opts.title = opts.title or "Success"
      opts.icon = ""
      notify(msg, vim.log.levels.INFO, opts)
    end
    
    local function notify_error(msg, opts)
      opts = opts or {}
      opts.title = opts.title or "Error"
      opts.icon = ""
      notify(msg, vim.log.levels.ERROR, opts)
    end
    
    local function notify_warning(msg, opts)
      opts = opts or {}
      opts.title = opts.title or "Warning"
      opts.icon = ""
      notify(msg, vim.log.levels.WARN, opts)
    end
    
    local function notify_info(msg, opts)
      opts = opts or {}
      opts.title = opts.title or "Info"
      opts.icon = ""
      notify(msg, vim.log.levels.INFO, opts)
    end
    
    -- Make custom functions available globally
    _G.notify_success = notify_success
    _G.notify_error = notify_error
    _G.notify_warning = notify_warning
    _G.notify_info = notify_info
  end,
} 