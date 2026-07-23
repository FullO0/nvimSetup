return { -- Code Folding
  'kevinhwang91/nvim-ufo',
  dependencies = 'kevinhwang91/promise-async',
  enabled = false,
  config = function()
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    require('ufo').setup()
  end,
}
