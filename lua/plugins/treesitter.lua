return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function(_)
        require('nvim-treesitter.configs').setup {
            ensure_installed = {  },
            sync_install = false,
            auto_install = false,
            highlight = {
                enabled = true,
                additional_vim_regex_highlighting = false,
            },
            incremental_selection = {
              enable = true,
              keymaps = {
                init_selection = "gnn",
                node_incremental = "grn",
                scope_incremental = false,
                node_decremental = "grm",
              },
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
