return { -- Colorizer for hex codes / functions
  'catgoose/nvim-colorizer.lua',
  event = 'BufReadPre',
  opts = {

    options = {

      parsers = {
        names = {
          enable = false,
        },
      },

      -- Hex coloring
      hex = {
        rrggbbaa = true,
      },

      -- Function coloring
      rgb = { enable = true },
      hsl = { enable = true },
      oklch = { enable = true },
      hwb = { enable = true },
      lab = { enable = true },
      lch = { enable = true },
      css_color = { enable = true },

      -- older color data types
      xterm = { enable = true },
      xcolor = { enable = true },
      hsluv = { enable = true },
    },

    display = {
      mode = 'background',
    },
  },
}
