return {
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
        init = function(_)
            require 'nvim-treesitter.configs'.setup {
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
                            ["if"] = { query = "@function.inner", desc = "Select inner part of a function" },
                        },
                        selection_modes = {
                            ['@parameter.outer'] = 'v', -- charwise
                            ['@function.outer'] = 'V',  -- linewise
                            ['@class.outer'] = '<c-v>', -- blockwis
                        },
                        include_surrounding_whitespace = false,
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]l"] = "@loop.*",
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                        },
                    },
                },
            }
            local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
        end
    },
    {
        "chrisgrieser/nvim-various-textobjs",
        event = "UIEnter",
        opts = {
            keymaps = {
                useDefaults = true,
                disabledDefaults = { 'L' },
            },
            notify = {
                whenObjectNotFound = true,
            },

        },
        keys = {
            {'U', mode = { 'o', 'x' }, '<cmd>lua require("various-textobjs").url()<CR>'},
        }
    },
}
