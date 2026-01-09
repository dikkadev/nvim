return {
    {
        'lewis6991/gitsigns.nvim',
        event = "BufReadPost",
        dependencies = { 'folke/which-key.nvim' },
        init = function(_)
            require('gitsigns').setup {
                on_attach = function(bufnr)
                    local gitsigns = require('gitsigns')

                    local function map(mode, l, r, name, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        opts.desc = name
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']h', function()
                        if vim.wo.diff then
                            vim.cmd.normal({ ']h', bang = true })
                        else
                            gitsigns.nav_hunk('next')
                        end
                    end, 'Next hunk')

                    map('n', '[h', function()
                        if vim.wo.diff then
                            vim.cmd.normal({ '[h', bang = true })
                        else
                            gitsigns.nav_hunk('prev')
                        end
                    end, 'Previous hunk')

                    map('n', '<leader>hr', gitsigns.reset_hunk, 'Reset hunk')
                    map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                        'Reset hunk')
                    map('n', '<leader>hR', gitsigns.reset_buffer, 'Reset buffer')
                    map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end, 'Blame line')
                    map('n', '<leader>hd', gitsigns.diffthis, 'Diff staged')
                    map('n', '<leader>hD', function() gitsigns.diffthis('~') end, 'Diff HEAD')
                    map('n', '<leader>td', gitsigns.toggle_deleted, 'Toggle deleted')

                    map('o', 'sh', ':<C-U>Gitsigns select_hunk<CR>', 'Select hunk')
                end
            }
        end,
    },
    {
        'kdheepak/lazygit.nvim',
        keys = {
            { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
        },
    },
    {
        'pwntester/octo.nvim',
        cmd = { "Octo" },
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'nvim-tree/nvim-web-devicons',
        },
        opts = {},
    }
}
