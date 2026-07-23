return { -- Lualine status line plugin
  'nvim-lualine/lualine.nvim',
  requires = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = 'onedark',
      globalstatus = true,
    },
    tabline = {},
    winbar = {},
  },
}
