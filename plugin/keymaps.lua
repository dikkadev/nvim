local set = vim.keymap.set

set('n', '<leader>q', ':set wrap!<CR>')

set('n', '<leader>T', ':tabe %<CR>')
set('n', '<leader>t', ':tabe <CR>')

set('n', '<leader>Y', ':let @+ = expand("%:p")<CR>')

set({'n', 'x', 'o'}, 'gs', '^')
set({'n', 'x', 'o'}, 'ge', '$')

set('n', 'gh', ':tabedit <cfile><CR>')

set('', '<C-s>', vim.cmd.w)

set('n', 'n', 'nzz')
set('n', 'N', 'Nzz')

set('n', '<C-p>', 'i<CR><Esc>')

set('n', 'Q', '<Nop>')

set('i', '<C-c>', '<Esc>')
set('i', '<C-a>', '<Home>')

set('x', '<leader>p', '"_dp')

set('n', '<A-j>', 'gT')
set('n', '<A-k>', 'gt')
set('', '<A-J>', ':tabm -1<CR>')
set('', '<A-K>', ':tabm +1<CR>')

