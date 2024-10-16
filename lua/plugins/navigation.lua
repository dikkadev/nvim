return {
    {
        "stevearc/oil.nvim",
        opts = {},
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            default_file_explorer = true,
            skip_confirm_for_simple_edits = true,
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name, _)
                    return name:match(".git/")
                end,
            }
        },
        keys = {
            { '-', '<CMD>Oil<CR>', desc = 'Open file explorer' },
        }
    },

    {
        'folke/flash.nvim',
        event = 'VeryLazy',
        opts = {
            modes = {
                char = {
                    enabled = false,
                },
            },
        },
        keys = {
            { '<C-f>', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end,   desc = 'Flash' },
            { '<c-s>', mode = { 'c' },           function() require('flash').toggle() end, desc = 'Toggle Flash Search' },
        },
    },

    {
        'rmagatti/auto-session',
        opts = {
            log_level = "error",
            cwd_change_handling = {
                restore_upcoming_session = true,
                pre_cwd_changed_hook = nil,
                post_cwd_changed_hook = function()
                    require("lualine").refresh()
                end,
            },
        },
    },
}
