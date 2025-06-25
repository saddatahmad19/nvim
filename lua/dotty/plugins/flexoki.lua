return {
    'kepano/flexoki-neovim', name = 'flexoki',
    lazy = false,
    priority = 1000,
    config = function()
        require('flexoki').setup({
            transparent = true,
        })
        vim.cmd.colorscheme 'flexoki'

        vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'None' })
        vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'None' })
    end,
}