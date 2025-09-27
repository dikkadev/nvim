return {
    {
        'nvim-treesitter/nvim-treesitter',
        event = { "BufReadPost", "BufNewFile" },
        build = ':TSUpdate',
        config = function(_)
            require('nvim-treesitter.configs').setup {
                ensure_installed = {},
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

            local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

            parser_config.d2 = {
                install_info = {
                    url = 'https://git.pleshevski.ru/pleshevskiy/tree-sitter-d2',
                    revision = 'main',
                    files = { 'src/parser.c', 'src/scanner.c' },
                },
                filetype = 'd2',
            };
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
    },
    {
        'fei6409/log-highlight.nvim',
        config = function()
            require('log-highlight').setup {}
        end,
    },
}
