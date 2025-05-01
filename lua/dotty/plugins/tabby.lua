return {
    'nanozuki/tabby.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        local theme = {
            fill = { fg = '#8087a2', bg = '#252931' },
            head = { fg = '#a6accd', bg = '#2f334d', style = 'italic' },
            current_tab = {
                fg = '#c3e88d',
                bg = '#1a1b26',
                style = 'bold',
            },
            tab = {
                fg = '#828bb8',
                bg = '#2f334d',
            },
            win = {
                fg = '#9da5d7',
                bg = '#2f334d',
            },
            tail = {
                fg = '#a6accd',
                bg = '#2f334d',
                style = 'italic',
            }
        }

        -- Enable showtabline
        vim.opt.showtabline = 2

        -- Enable session support
        vim.opt.sessionoptions = 'curdir,folds,globals,help,tabpages,terminal,winsize'

        local function tab_label(tabid, active)
            local icon = active and '' or ''
            local number = vim.api.nvim_tabpage_get_number(tabid)
            
            -- Get the first window in the tab
            local win_id = vim.api.nvim_tabpage_list_wins(tabid)[1]
            -- Get the buffer number of that window
            local buf_id = vim.api.nvim_win_get_buf(win_id)
            -- Get the full path of the buffer
            local file_path = vim.api.nvim_buf_get_name(buf_id)
            
            local name
            if file_path and file_path ~= '' then
                -- Get just the file name for regular files
                local file_type = vim.fn.getftype(file_path)
                if file_type == 'file' then
                    name = vim.fn.fnamemodify(file_path, ':t')
                else
                    -- For non-files (like directories), show the directory name
                    name = vim.fn.fnamemodify(file_path, ':h:t')
                end
            else
                name = 'Tab ' .. number
            end
            
            return string.format(' %s %s ', icon, name)
        end

        require('tabby.tabline').set(function(line)
            return {
                line.tabs().foreach(function(tab)
                    local hl = tab.is_current() and theme.current_tab or theme.tab
                    return {
                        line.sep('', hl, theme.fill),
                        tab_label(tab.id, tab.is_current()),
                        line.sep('', hl, theme.fill),
                        hl = hl,
                        margin = ' ',
                    }
                end),
                line.spacer(),
                hl = theme.fill,
            }
        end)

        -- Tab management keymaps
        local keymap = vim.keymap
        keymap.set("n", "<leader>tt", ":$tabnew<CR>", { desc = "New Tab" })
        keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Close Tab" })
        keymap.set("n", "<leader>to", ":tabonly<CR>", { desc = "Close Other Tabs" })
        keymap.set("n", "<leader>tl", ":tabn<CR>", { desc = "Next Tab" })
        keymap.set("n", "<leader>th", ":tabp<CR>", { desc = "Previous Tab" })
        keymap.set("n", "<leader>tmp", ":-tabmove<CR>", { desc = "Move Tab Left" })
        keymap.set("n", "<leader>tmn", ":+tabmove<CR>", { desc = "Move Tab Right" })
        keymap.set("n", "<leader>tr", ":Tabby rename_tab ", { desc = "Rename Tab" })
        keymap.set("n", "<leader>tw", ":Tabby pick_window<CR>", { desc = "Pick Window" })
        keymap.set("n", "<leader>tj", ":Tabby jump_to_tab<CR>", { desc = "Jump to Tab" })
    end,
}

