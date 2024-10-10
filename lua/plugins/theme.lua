return {
    {
        'nyoom-engineering/oxocarbon.nvim',
        dependencies = {

        },
        init = function()
            vim.cmd [[colorscheme oxocarbon]]
            vim.cmd [[ hi Visual guifg=#17172b ]]
            vim.cmd [[ hi Visual guibg=#e1e132 ]]
            -- vim.cmd [[ hi Normal guibg=#11131D ]]
            -- vim.cmd [[ hi Normal guibg=#070510 ]]
            -- vim.cmd [[ hi Normal guibg=#171036 ]]
        end,
    },
}
