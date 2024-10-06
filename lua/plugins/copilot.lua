return {
    {
        'github/copilot.vim',
        init = function(_)
            vim.g.copilot_filetypes = { markdown = true }
        end
    },
}
