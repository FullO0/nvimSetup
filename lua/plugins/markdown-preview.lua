return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = { 'markdown' },
  build = function()
    vim.fn['mkdp#util#install']()
  end,
  init = function()
    -- Ensure it only loads for markdown files
    vim.g.mkdp_filetypes = { 'markdown' }
  end,
  keys = require('config.plugin-keymaps').keys.markdown_preview,
}
