-- Disable LSP plugins if NVIM_NO_LSP is set in the environment
local lsp_disabled = os.getenv 'NVIM_NO_LSP' ~= nil

return { -- Main LSP Configuration
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    -- Mason must be loaded before its dependents so we need to set it up here.
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Useful status updates for LSP.
    { 'j-hui/fidget.nvim', opts = {} },

    -- Allows extra capabilities provided by blink.cmp
    'saghen/blink.cmp',
  },
  enabled = function()
    return not lsp_disabled
  end,
  config = function()
    -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
    -- and elegantly composed help section, `:help lsp-vs-treesitter`

    -- LSP-specific mappings are centralized in one place for easier maintenance.
    require('config.plugin-keymaps').setup_lsp_keymaps()

    -- Diagnostic Config
    -- See :help vim.diagnostic.Opts
    vim.diagnostic.config {
      severity_sort = true,
      float = { border = 'rounded', source = 'if_many' },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = '󰅚 ',
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.INFO] = '󰋽 ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
      } or {},
      virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
          local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            [vim.diagnostic.severity.WARN] = diagnostic.message,
            [vim.diagnostic.severity.INFO] = diagnostic.message,
            [vim.diagnostic.severity.HINT] = diagnostic.message,
          }
          return diagnostic_message[diagnostic.severity]
        end,
      },
    }

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- Enable the following language servers providers (LSP)
    local servers = {
      -- C and C++
      clangd = {
        cmd = {
          'clangd',
          '--background-index',
          '--clang-tidy',
        },
      },

      -- Python
      basedpyright = {
        settings = {
          basedpyright = {
            disableOrganizeImports = true,
            analysis = {
              reportUnusedImport = 'none',
              reportUnusedVariable = 'none',
            },
          },
        },
      },
      ruff = {
        on_attach = function(client, _)
          client.server_capabilities.hoverProvider = false
        end,
      },

      -- R
      r_language_server = {},

      -- Rust
      rust_analyzer = {},

      -- Java
      jdtls = {},

      -- Makefile
      cmake = {},

      -- Bash
      bashls = {},

      -- Lua
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            workspace = {
              checkThirdParty = false,
              ignoreDir = { '/lua' },
            },
            runtime = {
              version = 'LuaJIT',
              pathStrict = false,
            },
          },
        },
      },

      -- JavaScript, JSX, and TypeScript
      ts_ls = {},
      eslint = {},

      -- HTML
      html = {},

      -- CSS
      cssls = {},
    }

    -- Raw list of tools/LSPs to check
    local raw_tools = vim.tbl_keys(servers or {})
    vim.list_extend(raw_tools, {
      -- Formatters
      'stylua',
      'ruff',
      'clang-format',
      'google-java-format',
      'shfmt',
      'prettier',

      -- Linters
      'checkstyle',
      'checkmake',
      'shellcheck',
    })

    -- Explicitly skipped tools
    local skip = { ['r_language_server'] = true }

    -- Mapping nvim-lspconfig keys to Mason package names
    local lsp_to_mason = {
      cmake = 'cmake-language-server',
      bashls = 'bash-language-server',
      lua_ls = 'lua-language-server',
      ts_ls = 'typescript-language-server',
      eslint = 'eslint-lsp',
      html = 'html-lsp',
      cssls = 'css-lsp',
      rust_analyzer = 'rust-analyzer',
    }

    -- Mapping Mason package names to binary commands for system PATH check
    local mason_to_binary = {
      ['lua-language-server'] = 'lua-language-server',
      ['bash-language-server'] = 'bash-language-server',
      ['typescript-language-server'] = 'typescript-language-server',
      ['eslint-lsp'] = 'vscode-eslint-language-server',
      ['html-lsp'] = 'vscode-html-language-server',
      ['css-lsp'] = 'vscode-css-language-server',
      ['cmake-language-server'] = 'cmake-language-server',
      ['rust-analyzer'] = 'rust-analyzer',
    }

    -- Filter and translate tools safely
    local ensure_installed = {}
    for _, tool in ipairs(raw_tools) do
      if not skip[tool] then
        local mason_name = lsp_to_mason[tool] or tool
        local binary_name = mason_to_binary[mason_name] or mason_name

        -- Only ask Mason to install if the binary isn't in global PATH
        if vim.fn.executable(binary_name) == 0 then
          table.insert(ensure_installed, mason_name)
        end
      end
    end

    -- Install tools
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    -- Loop through the servers table and set them up natively
    if not lsp_disabled then
      for server_name, server_config in pairs(servers) do
        -- Inject your blink.cmp capabilities
        server_config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server_config.capabilities or {})

        -- Use Neovim 0.11 native LSP API
        vim.lsp.config(server_name, server_config)
        vim.lsp.enable(server_name)
      end
    end
  end,
}
