-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Window management keybinds
vim.keymap.set('n', '<leader>wn', ':WintabsNext<CR>', { noremap = true, silent = true, desc = '[W]intabs [N]ext' })
vim.keymap.set('n', '<leader>wp', ':WintabsPrevious<CR>', { noremap = true, silent = true, desc = '[W]intabs [P]revious' })
vim.keymap.set('n', '<leader>wf', ':WintabsFirst<CR>', { noremap = true, silent = true, desc = '[W]intabs [F]irst' })
vim.keymap.set('n', '<leader>wl', ':WintabsLast<CR>', { noremap = true, silent = true, desc = '[W]intabs [L]ast' })
vim.keymap.set('n', '<leader>wct', ':WintabsClose<CR>', { noremap = true, silent = true, desc = '[W]intabs [C]lose [T]ab' })
vim.keymap.set('n', '<leader>wcw', ':WintabsCloseWindow<CR>', { noremap = true, silent = true, desc = '[W]intabs [C]lose [W]indow' })

-- Open Nvim-tree file tree system
vim.keymap.set('n', '<leader>d', ':NvimTreeToggle<CR>', { noremap = true, silent = true, desc = '[D]irectory tree' })

-- Swap 'a' and 'A' behavior
vim.keymap.set('n', 'a', 'A', { noremap = true, silent = true })
vim.keymap.set('n', 'A', 'a', { noremap = true, silent = true })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Make sure not to use arrow keys
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<leader>wH', '<C-w><C-h>', { desc = '[W]indow [h] left' })
vim.keymap.set('n', '<leader>wL', '<C-w><C-l>', { desc = '[W]indow [l] right' })
vim.keymap.set('n', '<leader>wJ', '<C-w><C-j>', { desc = '[W]indow [j] down' })
vim.keymap.set('n', '<leader>wK', '<C-w><C-k>', { desc = '[W]indow [k] up' })
