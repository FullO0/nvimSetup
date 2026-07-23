return { -- Python Venv Selector
  'linux-cultist/venv-selector.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
  },
  ft = 'python',
  opts = {
    name = { 'venv', '.venv', 'env', '.env' },
    anaconda_bass_path = '/home/christian/anaconda3/',
    anaconda_envs_path = '/home/christian/anaconda3/envs/',
  },
  keys = {
    { '<leader>pvs', '<cmd>VenvSelect<cr>', desc = '[P]ython [V]env [S]elector' },
  },
}
