return {
    {
        'ofirgall/ofirkai.nvim',
        priority = 1000,
        config = function()
            vim.cmd [[colorscheme ofirkai-darkblue]]
            vim.cmd [[ hi Visual guifg=#17172b ]]
            vim.cmd [[ hi Visual guibg=#e1e132 ]]
        end,
    },
}
