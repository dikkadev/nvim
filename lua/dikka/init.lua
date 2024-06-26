vim.g.mapleader = ' '
unix = jit.os == 'Linux' or jit.os == 'OSX' or jit.os == 'BSD'

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

vim.opt.spelllang = 'en_us'
vim.opt.spell = true
vim.opt.wrapscan = true

-- KEYMAPS
vim.keymap.set('n', '<leader>q', ':set wrap!<CR>')
vim.keymap.set('n', '<leader>w', '<C-w>')
vim.keymap.set('n', '<leader>T', ':tabe %<CR>')
vim.keymap.set('n', '<leader>t', ':tabe <CR>')
vim.keymap.set('n', '<leader>e', ':e <CR>')
vim.keymap.set('n', '<leader>c', ':')
vim.keymap.set('n', '<leader>d', ':lcd %:p:h<CR>')
vim.keymap.set('n', '<leader>y', ':let @+ = expand("%")<CR>')
vim.keymap.set('n', '<leader>Y', ':let @+ = expand("%:p")<CR>')

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
vim.keymap.set({ 'n', 'v' }, '<A-x>', ':xa<CR>')

vim.keymap.set('n', 'Q', '<Nop>')

vim.keymap.set('n', 'vag', 'ggVG')

vim.keymap.set('i', '<C-c>', '<Esc>')
vim.keymap.set('i', '<C-a>', '<Home>')

vim.keymap.set('x', '<leader>p', '|_dP')

vim.keymap.set('n', '<A-j>', 'gT')
vim.keymap.set('n', '<A-k>', 'gt')

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
            sections = {
                lualine_c = {
                    {
                        'filename',
                        path = 1,
                    },
                },
            },
        },
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    },
    {
        'nyoom-engineering/oxocarbon.nvim',
        init = function()
            vim.cmd [[colorscheme oxocarbon]]
            vim.cmd [[ hi Visual guifg=#55559b ]]
            vim.cmd [[ hi Visual guibg=#e1e132 ]]
        end
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
        "stevearc/oil.nvim",
        opts = {},
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("oil").setup({
                default_file_explorer = true,
                skip_confirm_for_simple_edits = true,
                view_options = {
                    show_hidden = true,
                    is_always_hidden = function(name, _)
                        return name:match(".git")
                    end,

                }
            })
        end,
        keys = {
            { '<leader>pv', '<CMD>Oil<CR>', desc = 'Open file explorer' },
            { '-',          '<CMD>Oil<CR>', desc = 'Open file explorer' },
        }
    },
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        init = function(_)
            local harpoon = require("harpoon")
            harpoon:setup()

            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

            vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)
            vim.keymap.set("n", "<C-n>", function() harpoon:list():select(5) end)
            vim.keymap.set("n", "<C-m>", function() harpoon:list():select(6) end)
        end
    },
    {
        'williamboman/mason.nvim',
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
            'petertriho/cmp-git',
        },
        init = function(_)
            local cmp = require('cmp')
            local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'git' },
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
            require("cmp_git").setup()
        end
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'williamboman/mason.nvim',
        },
        opts = {
            ensure_installed = { 'lua_ls', 'rust_analyzer', 'marksman', 'gopls' },
        },
    },
    {
        'neovim/nvim-lspconfig',
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
                    vim.keymap.set('n', 'gD', function()
                        vim.cmd('tab split')
                        vim.lsp.buf.definition()
                    end, opts)
                    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
                    vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)
                    vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)

                    vim.keymap.set('n', '<leader>vw', '<cmd>TroubleToggle workspace_diagnostics<cr>', opts)
                    vim.keymap.set('n', '<leader>vd', '<cmd>TroubleToggle document_diagnostics<cr>', opts)
                    vim.keymap.set('n', '<leader>vr', '<cmd>TroubleToggle lsp_references<cr>', opts)
                    vim.keymap.set('n', '<leader>vc', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
                    vim.keymap.set('n', '<leader>vp', require('actions-preview').code_actions, opts)
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

            require('lspconfig').openscad_lsp.setup {
                cmd = { "/home/dikka/projs/openscad-lsp/target/release/openscad-lsp" },
                filetypes = { "openscad" },
                root_dir = require('lspconfig/util').root_pattern(".git", vim.fn.getcwd()),
                -- settings = {
                --     scad = {
                --         includePaths = { "/home/dikka/3d" }
                --     }
                -- }
            }
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        config = function(_)
            require('nvim-treesitter.configs').setup {
                {
                    ensure_installed = { "markdown", "javascript", "go", "rust", "typescript", "c", "lua", "vimdoc", "templ" },
                    highlight = {
                        enable = true,
                        additional_vim_regex_highlighting = false,
                    },
                }
            }
            local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
            parser_config.openscad = {
                install_info = {
                    url = "https://github.com/bollian/tree-sitter-openscad",
                    files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
                }
            }
            vim.treesitter.language.register('templ', 'templ')
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
                        lookahead = true,
                        keymaps = {
                            ["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
                            ["if"] = { query = "@function.inner", desc = "Select inner part of a function" },
                        },
                        selection_modes = {
                            ['@parameter.outer'] = 'v', -- charwise
                            ['@function.outer'] = 'V',  -- linewise
                            ['@class.outer'] = '<c-v>', -- blockwise
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
        'Wansmer/sibling-swap.nvim',
        dependencies = {
            'nvim-treesitter',
            init = function(_)
                require('sibling-swap').setup({
                    use_default_keymaps = false,
                    highlight_node_at_cursor = { ms = 350, hl_opts = { link = 'IncSearch' } },
                })
            end,
        },
        keys = {
            { '<leader>n', function() require('sibling-swap').swap_with_right_with_opp() end, desc = 'Swap with right' },
            { '<leader>N', function() require('sibling-swap').swap_with_left_with_opp() end,  desc = 'Swap with left' },
        }
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
        'tpope/vim-commentary',
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
        'sett17/quicksub.nvim',
        as = 'quicksub',
        keys = {
            { '<leader>s', function() require('quicksub.quicksub').quicksub() end, mode = 'v', desc = 'QuickSub' },
        },
    },
    {
        'github/copilot.vim',
        init = function(_)
            vim.g.copilot_filetypes = { markdown = true }
        end
    },
    {
        'kaarmu/typst.vim',
        ft = 'typst',
        lazy = false,
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
        'NoahTheDuke/vim-just',
    },
    {
        'IndianBoy42/tree-sitter-just',
    },
    {
        'vrischmann/tree-sitter-templ',
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        init = function(_)
            require('telescope').load_extension('fzf')
        end
    },
    {
        'pwntester/octo.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'nvim-tree/nvim-web-devicons',
        },
        opts = {},
        keys = {
            { '<leader>o', ':Octo actions<CR>', desc = 'Show all Octo actions' }
        }
    },
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        opts = {
            messages = {
                enabled = false,
            },
            views = {
                cmdline_popup = {
                    size = {
                        width = 080,
                        height = "auto",
                    },
                },
            }
        },
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        }
    },
    {
        'ellisonleao/dotenv.nvim',
        opts = {},
    },
    {
        'fatih/vim-go',
    },
    {
        'sbulav/nredir.nvim',
        keys = {
            { '<leader>r', ':Nredir !', desc = 'Nredir' },
        },
    },
    {
        "desdic/macrothis.nvim",
        opts = {},
        keys = {
            { "<leader>kd", function() require('macrothis').delete() end,   desc = "delete" },
            { "<leader>ke", function() require('macrothis').edit() end,     desc = "edit" },
            { "<leader>kl", function() require('macrothis').load() end,     desc = "load" },
            { "<leader>kn", function() require('macrothis').rename() end,   desc = "rename" },
            { "<leader>kr", function() require('macrothis').run() end,      desc = "run macro" },
            { "<leader>ks", function() require('macrothis').save() end,     desc = "save" },
            { "<leader>kx", function() require('macrothis').register() end, desc = "edit register" },
            {
                "<leader>kp",
                function() require('macrothis').copy_register_printable() end,
                desc =
                "Copy register as printable"
            },
            {
                "<leader>km",
                function() require('macrothis').copy_macro_printable() end,
                desc =
                "Copy macro as printable"
            },
        }
    },
    {
        'tjdevries/templ.nvim',
    },
    {
        'lewis6991/gitsigns.nvim',
        dependencies = { 'folke/which-key.nvim' },
        init = function(_)
            require('gitsigns').setup {
                on_attach = function(bufnr)
                    local gitsigns = require('gitsigns')
                    local whichkey = require('which-key')

                    local function map(mode, l, r, name, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                        whichkey.register({ [l] = { r, name } })
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
        'cameron-wags/rainbow_csv.nvim',
        config = true,
        ft = {
            'csv',
            'tsv',
            'csv_semicolon',
            'csv_whitespace',
            'csv_pipe',
            'rfc_csv',
            'rfc_semicolon'
        },
        cmd = {
            'RainbowDelim',
            'RainbowDelimSimple',
            'RainbowDelimQuoted',
            'RainbowMultiDelim'
        }
    },
    {
        'folke/flash.nvim',
        event = 'VeryLazy',
        opts = {},
        keys = {
            { 's',     mode = { 'n', 'x', 'o' }, function() require('flash').jump() end,   desc = 'Flash' },
            { '<c-s>', mode = { 'c' },           function() require('flash').toggle() end, desc = 'Toggle Flash Search' },
        },
    },
    {
        'Hoffs/omnisharp-extended-lsp.nvim',
        keys = {
            { '<leader>gd', function() require('omnisharp_extended').lsp_definition() end,      desc = 'Go to definition' },
            { '<leader>D',  function() require('omnisharp_extended').lsp_type_definition() end, desc = 'Type definition' },
            { '<leader>vr', function() require('omnisharp_extended').lsp_references() end,      desc = 'References' },
            { '<leader>gi', function() require('omnisharp_extended').lsp_implementation() end,  desc = 'Implementation' },
        },
    },
    {
        'chrishrb/gx.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = {
            { 'gx', '<cmd>Browse<cr>', mode = { 'n', 'x' }, desc = 'Browse' },
        },
        cmd = { 'Browse' },
        init = function(_)
            vim.g.netrw_nogx = 1
        end,
        -- config = true,
        submodules = false,
        config = function()
            require('gx').setup {
                open_browser_app = '/home/dikka/chrome_incognito.sh',
                open_browser_arg = { '--new-window' },
            }
        end,
    },
    {
        'AndrewRadev/switch.vim',
        keys = {
            { '<leader>s', ':Switch<CR>',        desc = 'Switch' },
            { '<leader>S', ':SwitchReverse<CR>', desc = 'Switch reverse' },
        },
        config = function()
            vim.g['switch_mapping'] = "<leader>s"
            vim.g['switch_custom_definitions'] = {
                vim.fn['switch#NormalizedCaseWords'] { 'sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday' },
                vim.fn['switch#NormalizedCase'] { 'yes', 'no' },
                vim.fn['switch#NormalizedCase'] { 'on', 'off' },
                vim.fn['switch#NormalizedCase'] { '0x00', '0x01' },
                vim.fn['switch#NormalizedCase'] { 'left', 'right', 'down', 'left' },
                vim.fn['switch#NormalizedCase'] { 'enable', 'disable' },
                vim.fn['switch#NormalizedCase'] { 'not', '/*not*/' },
                { '==', '!=' },
                {
                    ["\\<\\(\\l\\)\\(\\l\\+\\(\\u\\l\\+\\)\\+\\)\\>"] = "\\=toupper(submatch(1)) . submatch(2)",        -- Convert camelCase to CamelCase
                    ["\\<\\(\\u\\l\\+\\)\\(\\u\\l\\+\\)\\+\\>"] =
                    "\\=tolower(substitute(submatch(0), '\\(\\l\\)\\(\\u\\)', '\\1_\\2', 'g'))",                        -- Convert CamelCase to snake_case
                    ["\\<\\(\\l\\+\\)\\(_\\l\\+\\)\\+\\>"] = "\\U\\0",                                                  -- Convert snake_case to SCREAMING_SNAKE_CASE
                    ["\\<\\(\\u\\+\\)\\(_\\u\\+\\)\\+\\>"] = "\\=tolower(substitute(submatch(0), '_', '-', 'g'))",      -- Convert SCREAMING_SNAKE_CASE to kebab-case
                    ["\\<\\(\\l\\+\\)\\(-\\l\\+\\)\\+\\>"] = "\\=substitute(submatch(0), '-\\(\\l\\)', '\\u\\1', 'g')", -- Convert kebab-case to camelCase
                },
            }
        end,
    }
})

-- require("dikka.debugger")
vim.api.nvim_set_keymap('n', '<leader>;', ':lua require("dikka.python_repl").open_python_repl()<CR>',
    { noremap = true, silent = true })

vim.filetype.add({
    extension = {
        templ = "templ",
    },
})
vim.api.nvim_exec([[
  augroup FileTypeConfig
    autocmd!
    autocmd FileType templ setlocal commentstring=//\ %s
  augroup END
]], false)

vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 250 })
    end,
})

vim.cmd('Dotenv')
if vim.env.DISABLE_COPILOT == "true" then
    print('Disabling Copilot')
    vim.cmd('Copilot disable')
else
    vim.cmd('Copilot enable')
end

-- Define an autocmd group for Go-specific settings
vim.api.nvim_create_augroup("GoSpecificMappings", { clear = true })

-- Autocmd for Go files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    group = "GoSpecificMappings",
    callback = function()
        -- Set keybindings for .go files
        local opts = { noremap = true, silent = true }
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>gi", "<cmd>GoImpl<CR>", opts)
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>ge", "<cmd>GoIfErr<CR>", opts)
    end
})

-- vim.cmd('Copilot disable')

vim.cmd('autocmd BufEnter * TSBufEnable highlight')

vim.cmd('autocmd BufNewFile,BufRead *.cshtml set filetype=html.cshtml.razor')
vim.cmd('autocmd BufNewFile,BufRead *.razor set filetype=html.cshtml.razor')
