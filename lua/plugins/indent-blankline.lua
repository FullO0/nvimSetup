--- Custom colors ---
local status, c = pcall(require, 'custom.generated_colors')
if not status then
  c = {}
end

return { -- Add indentation guides even on blank lines
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  config = function()
    -- Dimmed indentation Color
    vim.api.nvim_set_hl(0, 'IblIndent', {
      fg = c.bg3,
      bg = 'None',
      nocombine = true,
    })

    -- Scope indentation Color
    vim.api.nvim_set_hl(0, 'IblScope', {
      fg = c.light_grey,
      bg = 'None',
      nocombine = true,
    })

    -- blank line settings
    require('ibl').setup {
      indent = {
        char = '▏',
        tab_char = '»',
        highlight = 'IblIndent',
      },

      whitespace = {
        highlight = 'IblIndent',
        remove_blankline_trail = false,
      },

      scope = {
        enabled = true,
        show_start = false,
        highlight = 'IblScope',

        -- Highlight closest indentation of the current row of the cursor
        include = {
          node_type = {
            lua = {
              'table_constructor',
              'field',
            },
            c = {
              'case_statement',
              'compound_statement',
              'initializer_list',
              'enumerator_list',
              'field_declaration_list',
              'parameter_list',
            },
            python = {
              'dictionary',
              'list',
              'set',
              'tuple',
              'parenthesized_expression',
              'argument_list',
              'dictionary_comprehension',
              'list_comprehension',
            },
          },
        },
      },
    }
  end,
}
