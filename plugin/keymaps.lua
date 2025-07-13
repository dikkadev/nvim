local set = vim.keymap.set

set('n', '<leader>q', ':set wrap!<CR>', { desc = 'Toggle line wrapping' })

set('n', '<leader>T', ':tabe %<CR>', { desc = 'Open current file in new tab' })
set('n', '<leader>t', ':tabe <CR>', { desc = 'Open new empty tab' })

set('n', '<leader>Y', ':let @+ = expand("%:p")<CR>', { desc = 'Yank full file path to clipboard' })

set({'n', 'x', 'o'}, 'gs', '^', { desc = 'Go to start of line' })
set({'n', 'x', 'o'}, 'ge', '$', { desc = 'Go to end of line' })

set('n', 'gh', ':tabedit <cfile><CR>', { desc = 'Open file under cursor in new tab' })

set('', '<C-s>', vim.cmd.w, { desc = 'Save file' })

set('n', 'n', 'nzz', { desc = 'Next search result and center screen' })
set('n', 'N', 'Nzz', { desc = 'Previous search result and center screen' })

set('n', '<C-p>', 'i<CR><Esc>', { desc = 'Insert blank line below' })

set('n', 'Q', '<Nop>', { desc = 'Disable Ex mode' })

set('i', '<C-c>', '<Esc>', { desc = 'Escape insert mode' })
set('i', '<C-a>', '<Home>', { desc = 'Go to start of line in insert mode' })

set('x', '<leader>p', '"_dp', { desc = 'Paste over without yanking replaced text' })

set('n', '<A-j>', 'gT', { desc = 'Go to previous tab' })
set('n', '<A-k>', 'gt', { desc = 'Go to next tab' })
set('', '<A-J>', ':tabm -1<CR>', { desc = 'Move tab left' })
set('', '<A-K>', ':tabm +1<CR>', { desc = 'Move tab right' })

set('n', '<leader>cpe', ':Copilot enable<CR>', { desc = 'Enable Copilot' })
set('n', '<leader>cpd', ':Copilot disable<CR>', { desc = 'Disable Copilot' })

set('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { desc = 'Show signature help' })

set('n', '<leader>cd', vim.diagnostic.setqflist, { desc = 'Open diagnostics in quickfix list' })

set('n', '<leader>N', '<cmd>enew<CR>', { noremap = true, silent = true, desc = 'Replace with new buffer' })

set('n', '<C-j>', ':cnext<CR>', { desc = 'Next quickfix item' })
set('n', '<C-k>', ':cprev<CR>', { desc = 'Previous quickfix item' })

set('n', '<leader>r', ':e!<CR>', { noremap = true, silent = true, desc = 'Reload current buffer' })

set('n', '<leader>lu', ':%s/\\r$//<CR>', { desc = 'Remove trailing carriage returns' })
