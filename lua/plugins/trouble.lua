return {
    {
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {},
        keys = {
            { '<leader>vw', '<cmd>Trouble diagnostics toggle focus=true<cr>',              desc = 'Toggle workspace diagnostics' },
            { '<leader>vd', '<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>', desc = 'Toggle buffer diagnostics' },
            { '<leader>vr', '<cmd>Trouble lsp toggle focus=true<cr>',                      desc = 'Toggle LSP info' },
        },
    },
}
