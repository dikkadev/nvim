return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function(_)
        require('nvim-treesitter.configs').setup {
            ensure_installed = {  },
            sync_install = false,
            auto_install = true,
            highlight = {
                enabled = true,
                additional_vim_regex_highlighting = true,
            },
        }
    end,
    keys = {
        {
            '<leader>z',
            function()
                vim.opt.foldmethod = 'expr'; vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
            end,
            desc = "Load folds"
        },
    }
}
