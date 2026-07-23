-- Disable every AI plugin if NVIM_NO_AI is set in the environment
local ai_disabled = os.getenv 'NVIM_NO_AI' ~= nil

return {
  'zbirenbaum/copilot.lua',

  enabled = function()
    return not ai_disabled
  end,

  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    vim.keymap.set('n', '<leader>cpt', '<cmd>Copilot toggle<cr>', { desc = '[C]o[P]ilot [T]oggle' })
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
