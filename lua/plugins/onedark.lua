--- Custom colors ---
local status, c = pcall(require, 'custom.generated_colors')
if not status then
  c = {}
end

return { -- Colorscheme
  'navarasu/onedark.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    local custom_colors = {
      black = c.black,
      bg0 = c.bg0,
      bg1 = c.bg1,
      bg2 = c.bg2,
      bg3 = c.bg3,
      bg_d = c.bg_d,
      bg_blue = c.bg_blue,
      bg_yellow = c.bg_yellow,
      fg = c.fg,
      purple = c.purple,
      green = c.green0,
      orange = c.orange,
      blue = c.blue,
      yellow = c.yellow,
      cyan = c.cyan,
      red = c.red,
      grey = c.grey,
      light_grey = c.light_grey,
      dark_cyan = c.dark_cyan,
      dark_red = c.dark_red,
      dark_yellow = c.dark_yellow,
      dark_purple = c.dark_purple,
      diff_add = c.diff_add,
      diff_delete = c.diff_delete,
      diff_change = c.diff_change,
      diff_text = c.diff_text,
    }

    require('onedark').setup {
      styles = {
        style = 'Warmer',
      },

      -- Override onedark default colors with my own
      colors = custom_colors,
    }
    require('onedark').load()

    -- Load the colorscheme
    vim.cmd.colorscheme 'onedark'
  end,
}
