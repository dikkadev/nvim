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
vim.opt.foldlevelstart = 99

-- KEYMAPS
vim.keymap.set('n', '<leader>q', 'set wrap!<CR>')
vim.keymap.set('n', '<leader>w', '<C-w>')
vim.keymap.set('n', '<leader>j', ':!just ')
vim.keymap.set('n', '<leader>t', ':tabedit %<CR>')
vim.keymap.set('n', '<leader>r', ':e <CR>')

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
        'williamboman/mason.nvim',
        lazy = false,
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        },
    },
    {
        'hrsh7th/cmp-nvim-lsp',
        dependencies = {
            'hrsh7th/nvim-cmp',
            'L3MON4D3/LuaSnip',
            'hrsh7th/cmp-buffer',
        },
        init = function(_)
            local cmp = require('cmp')
            local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                sources = {
                    { name = 'nvim_lsp' },
                },
                mapping = {
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ['<Enter>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<Up>'] = cmp.mapping.select_prev_item(cmp_select_opts),
                    ['<Down>'] = cmp.mapping.select_next_item(cmp_select_opts),
                    ['<C-p>'] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_prev_item(cmp_select_opts)
                        else
                            cmp.complete()
                        end
                    end),
                    ['<C-n>'] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_next_item(cmp_select_opts)
                        else
                            cmp.complete()
                        end
                    end),
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                window = {
                    documentation = {
                        max_height = 15,
                        max_width = 60,
                    }
                },
                formatting = {
                    fields = { 'abbr', 'menu', 'kind' },
                    format = function(entry, item)
                        local short_name = {
                            nvim_lsp = 'LSP',
                            nvim_lua = 'nvim'
                        }

                        local menu_name = short_name[entry.source.name] or entry.source.name

                        item.menu = string.format('[%s]', menu_name)
                        return item
                    end,
                },
            })
        end
    },
    {
        'williamboman/mason-lspconfig.nvim',
        lazy = false,
        dependencies = {
            'williamboman/mason.nvim',
        },
        opts = {
            ensure_installed = { 'lua_ls', 'rust_analyzer', 'marksman', 'gopls' },
        },
    },
    {
        'neovim/nvim-lspconfig',
        lazy = false,
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
            'hrsh7th/cmp-nvim-lsp',
            'aznhe21/actions-preview.nvim',
        },
        init = function(_)
            local lspconfig = require('lspconfig')
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

            require('mason-lspconfig').setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = lsp_capabilities,
                    })
                end,
            })

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
                    vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

                    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
                    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
                    vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)
                    vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)

                    vim.keymap.set('n', '<leader>vw', '<cmd>TroubleToggle workspace_diagnostics<cr>', opts)
                    vim.keymap.set('n', '<leader>vd', '<cmd>TroubleToggle document_diagnostics<cr>', opts)
                    vim.keymap.set('n', '<leader>vr', '<cmd>TroubleToggle lsp_references<cr>', opts)
                    vim.keymap.set('n', '<leader>vc', require('actions-preview').code_actions, opts)
                    vim.keymap.set('n', '<leader>va',
                        function() require('actions-preview').code_actions({ context = { only = { "source" } } }) end,
                        opts)
                    vim.keymap.set('n', '<leader>vn', function() vim.lsp.buf.rename() end, opts)

                    vim.keymap.set('n', '<leader>f',
                        function() vim.lsp.buf.format({ async = false, timeout_ms = 10000 }) end,
                        opts)

                    vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
                end,
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
        end,
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
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
        init = function(_)
            require 'nvim-treesitter.configs'.setup {
                textobjects = {
                    select = {
                        enable = true,

                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,

                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
                            ["if"] = { query = "@function.inner", desc = "Select inner part of a function" },
                            ["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
                            -- You can optionally set descriptions to the mappings (used in the desc parameter of
                            -- nvim_buf_set_keymap) which plugins like which-key display
                            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                            -- You can also use captures from other query groups like `locals.scm`
                            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                        },
                        -- You can choose the select mode (default is charwise 'v')
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * method: eg 'v' or 'o'
                        -- and should return the mode ('v', 'V', or '<c-v>') or a table
                        -- mapping query_strings to modes.
                        selection_modes = {
                            ['@parameter.outer'] = 'v', -- charwise
                            ['@function.outer'] = 'V',  -- linewise
                            ['@class.outer'] = '<c-v>', -- blockwise
                        },
                        -- If you set this to `true` (default is `false`) then any textobject is
                        -- extended to include preceding or succeeding whitespace. Succeeding
                        -- whitespace has priority in order to act similarly to eg the built-in
                        -- `ap`.
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * selection_mode: eg 'v'
                        -- and should return true of false
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
                            --
                            -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
                            ["]o"] = "@loop.*",
                            -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
                            --
                            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
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
            }

            local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

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
})
require("dikka.debugger")
