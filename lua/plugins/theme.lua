return {
    {
        'nyoom-engineering/oxocarbon.nvim',
        dependencies = {
            'ofirgall/ofirkai.nvim',
            'folke/tokyonight.nvim',
            { 'rose-pine/neovim', name = 'rose-pine' },
            'tiagovla/tokyodark.nvim',
            'projekt0n/github-nvim-theme'
        },
        init = function()
            -- vim.cmd [[colorscheme oxocarbon]]
            -- vim.cmd [[colorscheme rose-pine-main]]
            -- vim.cmd [[colorscheme tokyodark]]
            vim.cmd [[colorscheme ofirkai-darkblue]]
            vim.cmd [[ hi Visual guifg=#17172b ]]
            vim.cmd [[ hi Visual guibg=#e1e132 ]]
            -- vim.cmd [[ hi Normal guibg=#11131D ]]
            -- vim.cmd [[ hi Normal guibg=#070510 ]]
            -- vim.cmd [[ hi Normal guibg=#171036 ]]
        end,
    },
}
