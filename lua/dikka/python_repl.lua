local M = {}

print("python_repl module loading")
function M.open_python_repl()
    local threshold_width = 80
    local threshold_height = 30

    local win_width = vim.api.nvim_get_option("columns")
    local win_height = vim.api.nvim_get_option("lines")

    local width, height
    if win_width < threshold_width or win_height < threshold_height then
        width = win_width
        height = win_height
    else
        width = math.floor(win_width * 0.75)
        height = math.floor(win_height * 0.75)
    end

    local row = math.ceil((win_height - height) / 2) - 1
    local col = math.ceil((win_width - width) / 2)

    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    })

    vim.fn.termopen("python3")

    vim.api.nvim_buf_set_option(buf, 'buflisted', false)

    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('i', true, false, true), 'n', true)
end

return M
