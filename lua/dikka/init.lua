vim.g.mapleader = ' '

-- CONFIGS
vim.opt.clipboard = 'unnamedplus'
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.ignorecase = true

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.inccommand = "nosplit"

vim.opt.termguicolors = true

vim.opt.signcolumn = "yes:1"
vim.opt.scrolloff = 20

vim.opt.updatetime = 500

vim.opt.autoread = true
vim.opt.splitright = true
vim.opt.foldenable = false

-- KEYMAPS
vim.keymap.set('n', '<leader>q', 'set wrap!<CR>')
vim.keymap.set('n', '<leader>w', '<C-w>')
vim.keymap.set('n', '<leader>j', ':!just ')
vim.keymap.set('n', '<leader>t', ':tabedit %<CR>')

vim.keymap.set('n', 'gh', ':tabedit <cfile><CR>')
vim.keymap.set({ 'n', 'v' }, '<C-s>', vim.cmd.w)
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'zx', 'zz')
vim.keymap.set('n', '}', '}zz')
vim.keymap.set('n', '{', '{zz')
vim.keymap.set('n', '<C-t>', '3<C-e>')
vim.keymap.set('n', '<C-y>', '3<C-y>')
vim.keymap.set('n', '<C-p>', 'i<CR><Esc>')
vim.keymap.set({ 'n', 'v' }, '<A-a>', ':qa<CR>')
vim.keymap.set({ 'n', 'v' }, '<A-w>', ':wa<CR>')

vim.keymap.set('n', 'Q', '<Nop>')

vim.keymap.set('i', '<C-c>', '<Esc>')
vim.keymap.set('i', '<C-a>', '<Home>')

vim.keymap.set('x', '<leader>p', '|_dP')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '>-2<CR>gv=gv")

-- LAZY
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    print('Installing lazy.nvim....')
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
    print('Done.')
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {},
    },
    {
        'nvim-lua/plenary.nvim',
    },
    {
        'folke/neodev.nvim',
        opts = {},
    },
    {
        'nvim-lualine/lualine.nvim',
        opts = {
            theme = 'iceberg_dark',
        },
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = 'night',
        },
        init = function(_)
            vim.cmd [[colorscheme tokyonight]]
            vim.cmd [[ hi Visual guifg=#55559b ]]
            vim.cmd [[ hi Visual guibg=#e1e132 ]]
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        opts = {
            pickers = {
                find_files = {
                    hidden = true,
                },
            },
            defaults = {
                mappings = {
                    i = {
                        ['<C-x>'] = 'select_vertical'
                    }
                }
            },
        },
        keys = {
            { '<leader>pf', function() require('telescope.builtin').find_files() end, desc = 'Find files' },
            { '<leader>ps', function() require('telescope.builtin').live_grep() end,  desc = 'Find in files' },
            { '<leader>pg', function() require('telescope.builtin').git_files() end,  desc = 'Find git files' },
            { '<leader>pt', function() require('telescope.builtin').tags() end,       desc = 'Find tags' },
        }
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        init = function(_)
            require("telescope").setup {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                            -- even more opts
                        }
                    }
                }
            }
            require("telescope").load_extension("ui-select")
        end
    },
    {
        'nvim-telescope/telescope-file-browser.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        init = function(_)
            require("telescope").setup {
                extensions = {
                    file_browser = {
                        hijack_netrw = true,
                    },
                },
            }
            require("telescope").load_extension "file_browser"
        end,
        keys = {
            {
                '<leader>pv',
                function() require('telescope').extensions.file_browser.file_browser() end,
                desc = 'Find files'
            },
        }
    },
    {
        'ThePrimeagen/harpoon',
        keys = {
            { '<C-e>',     function() require('harpoon.ui').toggle_quick_menu() end, desc = 'Open harpoon menu' },
            { '<C-h>',     function() require('harpoon.ui').nav_file(1) end,         desc = 'Harpoon file 1' },
            { '<C-j>',     function() require('harpoon.ui').nav_file(2) end,         desc = 'Harpoon file 2' },
            { '<C-k>',     function() require('harpoon.ui').nav_file(3) end,         desc = 'Harpoon file 3' },
            { '<C-l>',     function() require('harpoon.ui').nav_file(4) end,         desc = 'Harpoon file 4' },
            { '<C-n>',     function() require('harpoon.ui').nav_file(5) end,         desc = 'Harpoon file 5' },
            { '<C-m>',     function() require('harpoon.ui').nav_file(6) end,         desc = 'Harpoon file 6' },
            { '<leader>a', function() require('harpoon.mark').add_file() end,        desc = 'Add file to harpoon' },
        },
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
            { 'folke/trouble.nvim' },
            { 'aznhe21/actions-preview.nvim' },
        },
        init = function(_)
            local lsp = require('lsp-zero').preset({
                manage_nvim_cmp = {
                    set_sources = 'recommended',
                    set_extra_mappings = false,
                }
            })
            lsp.on_attach(function(client, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
                local opts = { buffer = bufnr }

                vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
                vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

                vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set('n', '<leader>r', ':LspRestart<CR>', opts)

                vim.keymap.set('n', '<leader>vw', '<cmd>TroubleToggle workspace_diagnostics<cr>', opts)
                vim.keymap.set('n', '<leader>vd', '<cmd>TroubleToggle document_diagnostics<cr>', opts)
                vim.keymap.set('n', '<leader>vr', '<cmd>TroubleToggle lsp_references<cr>', opts)
                vim.keymap.set('n', '<leader>vc', require('actions-preview').code_actions, opts)
                vim.keymap.set('n', '<leader>vn', function() vim.lsp.buf.rename() end, opts)

                vim.keymap.set('n', '<leader>f',
                    function() vim.lsp.buf.format({ async = false, timeout_ms = 10000 }) end,
                    opts)

                vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
            end)
            lsp.setup()
            local cmp = require('cmp')
            cmp.setup({
                mapping = {
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                }
            })

            require('lspconfig').rust_analyzer.setup({
                on_attach = on_attach,
                settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            features = "all"
                        },
                    }
                }
            })

            require('lspconfig').typst_lsp.setup {
                settings = {
                    exportPdf = "never" -- Choose onType, onSave or never.
                }
            }
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            ensure_installed = { "markdown", "javascript", "go", "rust", "typescript", "c", "lua", "vim", "vimdoc",
                "query" },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        },
        init = function(_, opts)
            require('nvim-treesitter.configs').setup { opts }
            vim.opt.foldmethod = 'expr'
            vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        opts = {
            enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
            max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
            min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
            line_numbers = true,
            multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
            trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
            mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
            -- Separator between context and content. Should be a single character string, like '-'.
            -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
            separator = nil,
            zindex = 20,     -- The Z-index of the context window
            on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        },
        keys = {
            { '[c', function() require('treesitter-context').go_to_context() end, desc = 'Go to context' },
        }
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        opts = {
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
                        ["if"] = { query = "@function.inner", desc = "Select inner part of a function" },
                        ["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                    },
                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V',  -- linewise
                        ['@class.outer'] = '<c-v>', -- blockwise
                    },
                    include_surrounding_whitespace = false,
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>n"] = "@parameter.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]]"] = { query = "@class.outer", desc = "Next class start" },
                        ["]o"] = "@loop.*",
                        ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]["] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[["] = "@class.outer",
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[]"] = "@class.outer",
                    },
                },
            },
        },
        config = function(_, opts)
            require('nvim-treesitter.configs').setup({ opts })
        end,
        init = function(_)
            local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
        end
    },
    {
        'kdheepak/lazygit.nvim',
        keys = {
            { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        as = 'gitsigns',
        opts = {},
    },
    {
        'mbbill/undotree',
        keys = {
            { '<leader>u', '<cmd>UndotreeToggle<cr>', desc = 'Toggle UndoTree' },
        },
    },
    {
        'cohama/lexima.vim',
    },
    {
        'echasnovski/mini.surround',
        version = '*',
        opts = {},
    },
    {
        'echasnovski/mini.ai',
        version = '*',
        opts = {},
    },
    {
        'echasnovski/mini.comment',
        version = '*',
        opts = {},
    },
    {
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {},
    },
    {
        'aznhe21/actions-preview.nvim',
        opts = {},
        keys = {
            { '<leader>vc', function() require('actions-preview').code_actions() end, desc = 'Show code actions' },
        },
    },
    {
        'ziontee113/color-picker.nvim',
        opts = {},
        keys = {
            { '<leader>c', '<cmd>ColorPicker<cr>', desc = 'Color picker' },
        }
    },
    {
        'sett17/quicksub.nvim',
        as = 'quicksub',
        keys = {
            { '<leader>s', function() require('quicksub.quicksub').quicksub() end, mode = 'v', desc = 'QuickSub' },
        },
    },
    {
        'github/copilot.vim',
    },
    {
        'kaarmu/typst.vim',
        ft = 'typst',
        lazy = false,
    },
    {
        'eandrju/cellular-automaton.nvim',
        keys = {
            { '<leader>m', '<cmd>CellularAutomaton make_it_rain<CR>', desc = 'Make it rain' },
        },
    },
    {
        'rmagatti/auto-session',
        opts = {
            log_level = "error",
            cwd_change_handling = {
                restore_upcoming_session = true,   -- already the default, no need to specify like this, only here as an example
                pre_cwd_changed_hook = nil,        -- already the default, no need to specify like this, only here as an example
                post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
                    require("lualine").refresh()   -- refresh lualine so the new session name is displayed in the status bar
                end,
            },
        },
    },
    {
        'm-demare/attempt.nvim',
        opts = {},
        init = function(_)
            require('telescope').load_extension 'attempt'
        end,
        keys = {
            {
                '<leader>sn',
                function() require('attempt').new_select() end,
                desc = 'New from predefined',
                silent = true
            },
            {
                '<leader>si',
                function() require('attempt').new_input_ext() end,
                desc = 'custom extension',
                silent = true
            },
            { '<leader>sr', function() require('attempt').run() end, desc = 'Run', silent = true },
            {
                '<leader>sd',
                function() require('attempt').delete_buf() end,
                desc = 'Delete scratch file',
                silent = true
            },
            {
                '<leader>sc',
                function() require('attempt').rename_buf() end,
                desc = 'Rename scratch file',
                silent = true
            },
            {
                '<leader>sl',
                ':Telescope attempt<CR>',
                desc = 'Search scratch files',
                silent = true
            },
        },
    },
    {
        'numToStr/FTerm.nvim',
        opts = {
            dimensions = {
                height = 0.85,
                width = 0.85,
            },
            border = 'double'
        },
        keys = {
            { '<A-z>', '<CMD>lua require("FTerm").toggle()<CR>',            desc = 'Toggle FTerm' },
            { '<A-z>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', desc = 'Toggle FTerm', mode = 't' },
        },
    },
    {
        'djoshea/vim-autoread',
    },
    {
        'mfussenegger/nvim-dap',
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'mfussenegger/nvim-dap' },
        opts = {},
    },
    {
        'NoahTheDuke/vim-just',
    },
    {
        'IndianBoy42/tree-sitter-just',
    },
    {
        'c0r73x/neotags.lua',
        opts = {
            tools = {
                find = {
                    binary = 'fd',
                    args = { '-t', 'f', '--full-path' },
                }
            }
        },
    }
})
require("dikka.debugger")
