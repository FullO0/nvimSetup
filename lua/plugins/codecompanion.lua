-- Disable every AI plugin if NVIM_NO_AI is set in the environment
local ai_disabled = os.getenv 'NVIM_NO_AI' ~= nil

return { -- CodeCompanion
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-telescope/telescope.nvim',
    'zbirenbaum/copilot.lua',
  },

  enabled = function()
    return not ai_disabled
  end,

  -- Keymaps
  keys = {
    { '<leader>ccc', '<cmd>CodeCompanionChat Toggle<cr>', desc = '[C]ode[C]ompanion [C]hat' },
    { '<leader>ccp', '<cmd>CodeCompanion<cr>', desc = '[C]ode[C]ompanion [P]rompt' },
    { '<leader>cca', '<cmd>CodeCompanionActions<cr>', desc = '[C]ode[C]ompanion [A]ction' },
    { '<leader>ccC', '<cmd>CodeCompanionCmd<cr>', desc = '[C]ode[C]ompanion [C]md' },
    { '<leader>ccga', '<cmd>CodeCompanionChat Add<cr>', mode = 'v', desc = '[C]ode[C]ompanion [G]rap [A]dd Code to Chat' },
  },

  opts = {
    opts = {
      log_level = 'DEBUG',
    },

    interactions = {
      chat = {
        adapter = 'copilot',
        opts = { completion_provider = 'blink' },
        slash_commands = {
          ['buffer'] = { opts = { contains_code = true } },
          ['file'] = { opts = { contains_code = true } },
        },
      },

      inline = {
        adapter = 'copilot',
      },

      cmd = {
        adapter = 'ollama',
        model = 'llama3.1',
      },

      background = {
        adapter = {
          name = 'ollama',
          model = 'llama3.1',
        },
      },
    },

    display = {
      chat = {
        show_context = true,
        fold_context = false,
      },
    },
  },
}
