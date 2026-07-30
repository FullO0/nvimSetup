-- Disable every AI plugin if NVIM_NO_AI is set in the environment
local ai_disabled = os.getenv 'NVIM_NO_AI' ~= nil

return {
  'zbirenbaum/copilot.lua',

  enabled = function()
    return not ai_disabled
  end,

  keys = require('config.plugin-keymaps').keys.copilot,
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = '<C-l>',
          accept_word = '<C-k>',
          accept_line = '<C-j>',
          dismiss = '<C-h>',
        },
      },
      panel = { enabled = false },
    }
  end,
}
