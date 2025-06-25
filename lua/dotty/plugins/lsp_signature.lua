return {
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
  opts = {
    bind = true,
    handler_opts = {
      border = "rounded"
    },
    hint_enable = false,
    hint_prefix = "",
    hint_scheme = "String",
    hi_parameter = "Search",
    max_height = 12,
    max_width = 120,
    padding = "",
    shadow_blend = 36,
    shadow_guibg = "NONE",
    toggle_key = "<C-k>",
    toggle_key_flip_floatwin_setting = true,
    transparency = 0,
    zindex = 200,
  },
  config = function(_, opts) 
    require'lsp_signature'.setup(opts) 
  end
} 