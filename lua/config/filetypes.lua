-- [[ File Specific Settings ]]

-- Set wistl file type
vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
  pattern = { '*.wistl' },
  command = 'setfiletype wistl',
})

-- Wistl specific settinges
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'wistl' },
  callback = function()
    vim.bo.autoindent = true
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.tabstop = 4
    vim.bo.textwidth = 80
  end,
})

-- C & C++ specific settinges
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'c', 'cpp' },
  callback = function()
    if not vim.b.editorconfig or vim.tbl_isempty(vim.b.editorconfig) then
      vim.opt_local.tabstop = 4
      vim.opt_local.shiftwidth = 4
      vim.opt_local.expandtab = false
      vim.opt_local.textwidth = 80
    end
  end,
})

-- nasm specific settings
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'asm' },
  callback = function()
    if not vim.b.editorconfig or vim.tbl_isempty(vim.b.editorconfig) then
      vim.opt_local.tabstop = 2
      vim.opt_local.shiftwidth = 2
      vim.opt_local.expandtab = true
      vim.opt_local.textwidth = 80
    end
  end,
})

-- Lua specific settings
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'lua' },
  callback = function()
    if not vim.b.editorconfig or vim.tbl_isempty(vim.b.editorconfig) then
      vim.opt_local.tabstop = 2
      vim.opt_local.shiftwidth = 2
      vim.opt_local.expandtab = true
      vim.opt_local.textwidth = 120
    end
  end,
})

-- Python specific settings
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'py' },
  callback = function()
    if not vim.b.editorconfig or vim.tbl_isempty(vim.b.editorconfig) then
      vim.opt_local.tabstop = 4
      vim.opt_local.shiftwidth = 4
      vim.opt_local.expandtab = true
      vim.opt_local.textwidth = 120
    end
  end,
})

-- Makefile specific settings
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'make' },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 0
  end,
})

-- Java specific settings
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'java' },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

-- Web file specific settings
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'json', 'javascript', 'javascriptreact', 'css', 'html' },
  callback = function()
    if not vim.b.editorconfig or vim.tbl_isempty(vim.b.editorconfig) then
      vim.opt_local.expandtab = true
      vim.opt_local.tabstop = 2
      vim.opt_local.shiftwidth = 2
      vim.opt_local.softtabstop = 2
    end
  end,
})
