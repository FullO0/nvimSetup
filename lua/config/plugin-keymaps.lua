local M = {}

M.keys = {
  conform = {
    {
      '<leader>f',
      function()
        require('conform').format { async = false, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },

  codecompanion = {
    { '<leader>ccc', '<cmd>CodeCompanionChat Toggle<cr>', desc = '[C]ode[C]ompanion [C]hat' },
    { '<leader>ccp', '<cmd>CodeCompanion<cr>', desc = '[C]ode[C]ompanion [P]rompt' },
    { '<leader>cca', '<cmd>CodeCompanionActions<cr>', desc = '[C]ode[C]ompanion [A]ction' },
    { '<leader>ccC', '<cmd>CodeCompanionCmd<cr>', desc = '[C]ode[C]ompanion [C]md' },
    { '<leader>ccga', '<cmd>CodeCompanionChat Add<cr>', mode = 'v', desc = '[C]ode[C]ompanion [G]rab [A]dd Code to Chat' },
  },

  venv_selector = {
    { '<leader>pvs', '<cmd>VenvSelect<cr>', desc = '[P]ython [V]env [S]elector' },
  },

  debug = {
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>b',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint',
    },
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: See Last Session Result',
    },
  },

  telescope = {
    {
      '<leader>sh',
      function()
        require('telescope.builtin').help_tags()
      end,
      desc = '[S]earch [H]elp',
    },
    {
      '<leader>sk',
      function()
        require('telescope.builtin').keymaps()
      end,
      desc = '[S]earch [K]eymaps',
    },
    {
      '<leader>sf',
      function()
        require('telescope.builtin').find_files()
      end,
      desc = '[S]earch [F]iles',
    },
    {
      '<leader>ss',
      function()
        require('telescope.builtin').builtin()
      end,
      desc = '[S]earch [S]elect Telescope',
    },
    {
      '<leader>sw',
      function()
        require('telescope.builtin').grep_string()
      end,
      desc = '[S]earch Current [W]ord',
    },
    {
      '<leader>sg',
      function()
        require('telescope.builtin').live_grep()
      end,
      desc = '[S]earch by [G]rep',
    },
    {
      '<leader>sd',
      function()
        require('telescope.builtin').diagnostics()
      end,
      desc = '[S]earch [D]iagnostics',
    },
    {
      '<leader>sr',
      function()
        require('telescope.builtin').resume()
      end,
      desc = '[S]earch [R]esume',
    },
    {
      '<leader>s.',
      function()
        require('telescope.builtin').oldfiles()
      end,
      desc = '[S]earch Recent Files',
    },
    {
      '<leader><leader>',
      function()
        require('telescope.builtin').buffers()
      end,
      desc = 'Find Existing Buffers',
    },
    {
      '<leader>/',
      function()
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end,
      desc = '[/] Fuzzy Search in Current Buffer',
    },
    {
      '<leader>s/',
      function()
        require('telescope.builtin').live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end,
      desc = '[S]earch [/] in Open Files',
    },
    {
      '<leader>sn',
      function()
        require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = '[S]earch [N]eovim Files',
    },
  },

  copilot = {
    { '<leader>cpt', '<cmd>Copilot toggle<cr>', desc = '[C]o[P]ilot [T]oggle' },
  },
}

function M.setup_lsp_keymaps()
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
      map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
      map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
      map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
      map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
      map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
      map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

      ---@param client vim.lsp.Client
      ---@param method vim.lsp.protocol.Method
      ---@param bufnr? integer
      ---@return boolean
      local function client_supports_method(client, method, bufnr)
        if vim.fn.has 'nvim-0.11' == 1 then
          return client:supports_method(method, bufnr)
        else
          return client.supports_method(method, { bufnr = bufnr })
        end
      end

      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
          end,
        })
      end

      if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
        map('<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        end, '[T]oggle Inlay [H]ints')
      end
    end,
  })
end

function M.gitsigns_on_attach(bufnr)
  local gitsigns = require 'gitsigns'

  local function map(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  map('n', ']c', function()
    if vim.wo.diff then
      vim.cmd.normal { ']c', bang = true }
    else
      gitsigns.nav_hunk 'next'
    end
  end, { desc = 'Jump to Next Git [C]hange' })

  map('n', '[c', function()
    if vim.wo.diff then
      vim.cmd.normal { '[c', bang = true }
    else
      gitsigns.nav_hunk 'prev'
    end
  end, { desc = 'Jump to Previous Git [C]hange' })

  map('v', '<leader>hs', function()
    gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
  end, { desc = 'Git [S]tage Hunk' })
  map('v', '<leader>hr', function()
    gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
  end, { desc = 'Git [R]eset Hunk' })
  map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Git [S]tage Hunk' })
  map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Git [R]eset Hunk' })
  map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'Git [S]tage Buffer' })
  map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'Git [U]ndo Stage Hunk' })
  map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'Git [R]eset Buffer' })
  map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Git [P]review Hunk' })
  map('n', '<leader>hb', gitsigns.blame_line, { desc = 'Git [B]lame Line' })
  map('n', '<leader>hd', gitsigns.diffthis, { desc = 'Git [D]iff Against Index' })
  map('n', '<leader>hD', function()
    gitsigns.diffthis '@'
  end, { desc = 'Git [D]iff Against Last Commit' })
  map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle Git [B]lame Line' })
  map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle Git [D]eleted' })
end

return M
