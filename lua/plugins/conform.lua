return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = false, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    async = false,
    notify_on_error = false,
    format_on_save = function(bufnr)
      local enable_filetypes = { python = true, lua = true }
      if enable_filetypes[vim.bo[bufnr].filetype] then
        return {
          timeout_ms = 2500,
          lsp_format = 'fallback',
        }
      else
        return nil
      end
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      c = { 'clang_format' },
      python = { 'isort', 'black' },
      java = { 'google-java-format' },
      rust = { 'rustfmt', lsp_format = 'fallback' },
      make = { 'trim_whitespace' },
      bash = { 'shmft' },
      javascript = { 'prettier' },
      javascriptreact = { 'prettier' },
      css = { 'prettier' },
      html = { 'prettier' },
    },
  },
}
