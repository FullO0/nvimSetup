--- Custom colors ---
local status, c = pcall(require, 'custom.generated_colors')
if not status then
  c = {}
end

return { -- Vim window tabs plugin
  'zefei/vim-wintabs',
  dependencies = { 'zefei/vim-wintabs-powerline' },
  event = 'VimEnter',
  config = function()
    -- Enable the tabline
    vim.g.wintabs_enable = 1

    -- Set tabline format
    vim.g.wintabs_show = 'buffers'

    -- Custom colors
    vim.api.nvim_set_hl(0, 'WintabsActive', { fg = c.black, bg = c.green0 })
    vim.api.nvim_set_hl(0, 'WintabsInactive', { fg = c.light_grey, bg = c.bg1 })
    vim.api.nvim_set_hl(0, 'WintabsArrow', { fg = c.light_grey, bg = c.bg1 })
  end,
}
