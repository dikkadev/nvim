vim.b.current_buffer = vim.api.nvim_get_current_buf()
vim.keymap.set('n', '<leader>f', ":!d2 fmt %<CR>", { buffer = vim.b.current_buffer })
