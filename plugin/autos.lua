local api = vim.api 

api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 250 })
    end,
})

vim.api.nvim_create_augroup('autoreload', { clear = true })
vim.api.nvim_create_autocmd({'BufEnter', 'FocusGained'}, {
  group = 'autoreload',
  pattern = '*',
  command = 'checktime'
})
