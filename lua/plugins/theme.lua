return {
    {
       'nyoom-engineering/oxocarbon.nvim',
       init = function()
            vim.cmd [[colorscheme oxocarbon]]
            vim.cmd [[ hi Visual guifg=#17172b ]]
            vim.cmd [[ hi Visual guibg=#e1e132 ]]
        end
    },
}
