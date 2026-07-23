-- [[ Configure and install plugins ]]
--  Every `lua/plugins/*.lua` file returns a plugin spec and is auto-imported below.
--  `lua/kickstart/plugins/*.lua` holds the optional example plugins from kickstart.nvim
--  (debug.lua, autopairs.lua, gitsigns.lua).
--  `lua/custom/plugins/*.lua` is your own personal drop-in folder for extra plugins.
--
--  See `:help lazy.nvim-🔌-plugin-spec` for more info, or use Telescope:
--  `<space>sh` then `lazy.nvim-plugin`, followed by `<space>sr` to resume the search.
require('lazy').setup({
  { import = 'plugins' },
  { import = 'kickstart.plugins' },
  { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
