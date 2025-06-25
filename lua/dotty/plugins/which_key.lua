return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  config = function()
    local wk = require("which-key")

    -- Register all keymaps with leader prefix
    wk.register({
      -- Telescope mappings
      f = {
        name = "Find/Files",
        f = { "<cmd>Telescope find_files<cr>", "Find Files" },
        r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
        c = { "<cmd>Telescope grep_string<cr>", "Find Word Under Cursor" },
        g = { "<cmd>Telescope git_files<cr>", "Git Files" },
        t = { "<cmd>TodoTelescope<cr>", "Find TODOs" },
        s = { function() require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") }) end, "Search String" },
        m = { "<cmd>Telescope marks<cr>", "Browse Bookmarks" },
        M = { "<cmd>Telescope man_pages<cr>", "Search Man Pages" },
        k = { "<cmd>Telescope keymaps<cr>", "Show Keymaps" },
        C = { "<cmd>Telescope commands<cr>", "Show Commands" },
        S = { "<cmd>Telescope git_status<cr>", "Git Status" },
      },

      -- Add command palette feature within the main registration
      ["<space>"] = { 
        function()
          require("which-key").show(" ", {mode = "n", auto = true})
        end,
        "Command Palette" 
      },

      -- Neorg mappings
      n = {
        name = "Notes",
        n = { "<cmd>Neorg workspace notes<cr>", "Notes Workspace" },
        i = { "<cmd>Neorg workspace inbox<cr>", "Inbox Workspace" },
        j = { "<cmd>Neorg workspace journal<cr>", "Journal Workspace" },
        p = { "<cmd>Neorg workspace projects<cr>", "Projects Workspace" },
        x = { "<cmd>Neorg index<cr>", "Index" },
        r = { "<cmd>Neorg return<cr>", "Return" },
        t = { "<cmd>Neorg toc<cr>", "Table of Contents" },
        m = { "<cmd>Neorg inject-metadata<cr>", "Inject Metadata" },
        e = { "<cmd>Neorg export to-file<cr>", "Export to File" },
        E = { "<cmd>Neorg export to-markdown<cr>", "Export to Markdown" },
        v = { 
          function() 
            local neorg = require("neorg.core")
            local node = neorg.get_current_node()
            if node then
              local file = node:get_filename()
              if file then
                vim.cmd('botright vsplit ' .. vim.fn.fnameescape(file))
              end
            end
          end, 
          "Open in Vertical Split" 
        },
        w = { "<cmd>Neorg workspace<cr>", "Switch Workspace" },
      },

      -- Buffer management (updated for bufferline)
      b = {
        name = "Buffers",
        p = { "<cmd>BufferLineTogglePin<cr>", "Toggle pin" },
        P = { "<cmd>BufferLineGroupClose ungrouped<cr>", "Delete non-pinned buffers" },
        ["1"] = { "<cmd>BufferLineGoToBuffer 1<cr>", "Go to buffer 1" },
        ["2"] = { "<cmd>BufferLineGoToBuffer 2<cr>", "Go to buffer 2" },
        ["3"] = { "<cmd>BufferLineGoToBuffer 3<cr>", "Go to buffer 3" },
        ["4"] = { "<cmd>BufferLineGoToBuffer 4<cr>", "Go to buffer 4" },
        ["5"] = { "<cmd>BufferLineGoToBuffer 5<cr>", "Go to buffer 5" },
        c = { "<cmd>BufferLineClose<cr>", "Close buffer" },
        o = { "<cmd>BufferLineCloseOthers<cr>", "Close other buffers" },
        l = { "<cmd>BufferLineCloseLeft<cr>", "Close buffers to the left" },
        r = { "<cmd>BufferLineCloseRight<cr>", "Close buffers to the right" },
      },

      -- LSP mappings
      c = {
        name = "Code",
        a = { vim.lsp.buf.code_action, "Code Action" },
        d = { vim.diagnostic.open_float, "Line Diagnostics" },
        D = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Buffer Diagnostics" },
        r = { vim.lsp.buf.rename, "Rename" },
        s = { ":LspRestart<cr>", "Restart LSP" },
      },

      -- Git mappings (enhanced)
      g = {
        name = "Git",
        s = { "<cmd>Git<cr>", "Git Status" },
        d = { "<cmd>DiffviewOpen<cr>", "Open Diffview" },
        c = { "<cmd>DiffviewClose<cr>", "Close Diffview" },
        h = { "<cmd>DiffviewFileHistory<cr>", "File History" },
        l = { "<cmd>DiffviewLog<cr>", "Git Log" },
        f = { "<cmd>DiffviewFocusFiles<cr>", "Focus Files" },
        t = { "<cmd>DiffviewToggleFiles<cr>", "Toggle Files" },
      },

      -- Sessions
      s = {
        name = "Sessions",
        s = { function() require("persistence").load() end, "Restore Session" },
        l = { function() require("persistence").load({ last = true }) end, "Restore Last Session" },
        d = { function() require("persistence").stop() end, "Don't Save Session" },
      },

      -- AI/Copilot
      a = {
        name = "AI/Copilot",
        s = { "<cmd>Copilot status<cr>", "Copilot Status" },
        p = { "<cmd>Copilot panel<cr>", "Copilot Panel" },
        t = { "<cmd>Copilot toggle<cr>", "Toggle Copilot" },
      },
    }, { prefix = "<leader>" })

    -- Register non-leader keymaps
    wk.register({
      -- LSP mappings
      g = {
        name = "LSP Navigation",
        d = { "<cmd>Telescope lsp_definitions<cr>", "Go to Definition" },
        D = { vim.lsp.buf.declaration, "Go to Declaration" },
        i = { "<cmd>Telescope lsp_implementations<cr>", "Go to Implementation" },
        r = { "<cmd>Telescope lsp_references<cr>", "Find References" },
        t = { "<cmd>Telescope lsp_type_definitions<cr>", "Type Definition" },
      },
      K = { vim.lsp.buf.hover, "Show Documentation" },

      -- Diagnostic navigation
      ["]d"] = { vim.diagnostic.goto_next, "Next Diagnostic" },
      ["[d"] = { vim.diagnostic.goto_prev, "Previous Diagnostic" },

      -- Buffer navigation (updated for bufferline)
      ["]b"] = { "<cmd>BufferLineCycleNext<cr>", "Next Buffer" },
      ["[b"] = { "<cmd>BufferLineCyclePrev<cr>", "Previous Buffer" },
      ["<S-h>"] = { "<cmd>BufferLineCyclePrev<cr>", "Previous Buffer" },
      ["<S-l>"] = { "<cmd>BufferLineCycleNext<cr>", "Next Buffer" },
    })

    -- Register NvimTree buffer-specific mappings
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "NvimTree",
      callback = function(ev)
        wk.register({
          ["<C-]>"] = { "CD" },
          ["<C-e>"] = { "Open in Place" },
          ["<C-k>"] = { "Info" },
          ["<C-r>"] = { "Rename: Omit Filename" },
          ["<C-t>"] = { "Open: New Tab" },
          ["<C-v>"] = { "Open: Vertical Split" },
          ["<C-x>"] = { "Open: Horizontal Split" },
          ["<BS>"] = { "Close Directory" },
          ["<CR>"] = { "Open" },
          ["<Tab>"] = { "Open Preview" },
          [">"] = { "Next Sibling" },
          ["<"] = { "Previous Sibling" },
          ["."] = { "Run Command" },
          ["-"] = { "Up" },
          a = { "Create" },
          bd = { "Delete Bookmarked" },
          bmv = { "Move Bookmarked" },
          B = { "Toggle No Buffer" },
          c = { "Copy" },
          C = { "Toggle Git Clean" },
          d = { "Delete" },
          D = { "Trash" },
          E = { "Expand All" },
          e = { "Rename: Basename" },
          F = { "Clean Filter" },
          f = { "Filter" },
          ["g?"] = { "Help" },
          gy = { "Copy Absolute Path" },
          H = { "Toggle Dotfiles" },
          I = { "Toggle Git Ignore" },
          J = { "Last Sibling" },
          K = { "First Sibling" },
          m = { "Toggle Bookmark" },
          o = { "Open" },
          O = { "Open: No Window Picker" },
          p = { "Paste" },
          P = { "Parent Directory" },
          q = { "Close" },
          r = { "Rename" },
          R = { "Refresh" },
          s = { "Run System" },
          S = { "Search" },
          U = { "Toggle Hidden" },
          W = { "Collapse" },
          x = { "Cut" },
          y = { "Copy Name" },
          Y = { "Copy Relative Path" },
        }, { buffer = ev.buf })
      end,
    })
  end,
}
