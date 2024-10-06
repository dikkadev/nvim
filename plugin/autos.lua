local api = vim.api 

api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 250 })
    end,
})

-- vim.cmd('autocmd BufEnter * TSBufEnable highlight')
api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        api.nvim_command("TSBufEnable highlight")
    end,
})

api.nvim_create_augroup('autoreload', { clear = true })
api.nvim_create_autocmd({'BufEnter', 'FocusGained'}, {
  group = 'autoreload',
  pattern = '*',
  command = 'checktime'
})
