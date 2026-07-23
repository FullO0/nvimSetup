return { -- Nvim Tree plugin
  'kyazdani42/nvim-tree.lua',
  config = function()
    require('nvim-tree').setup {
      -- Configuration for nvim-tree
      disable_netrw = true, -- Disable netrw (built-in file explorer)
      hijack_netrw = true, -- Hijack netrw to open nvim-tree
      auto_reload_on_write = true, -- Auto reload when file changes
      view = {
        width = 30, -- Width of the file explorer
        side = 'left', -- Position on the left or right
      },
      update_focused_file = {
        enable = true,
        update_cwd = true, -- Update the current working directory
      },
    }
  end,
}
