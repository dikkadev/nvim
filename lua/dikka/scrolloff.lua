vim.cmd([[
    autocmd VimResized * lua UpdateScrollOff()
]])

-- Update scroll offset based on window height
function UpdateScrollOff()
    local lines = vim.fn.line('$')
    if lines > 45 then
        vim.opt.scrolloff = 8
    else
        vim.opt.scrolloff = 4
    end
end

UpdateScrollOff()
