-- require('dikka.scrolloff')

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
vim.opt.scrolloff = 16

vim.opt.updatetime = 500

vim.opt.autoread = true
vim.opt.splitright = true

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
    -- Utility
    {
        'nvim-lua/plenary.nvim',
    },
    {
        'folke/neodev.nvim',
    },
    {
        'nvim-lualine/lualine.nvim',
    },

    -- Theme
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },

    -- LSP & Autocompletion
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
        }
    },

    -- File Explorer & Searching
    {
        'nvim-telescope/telescope.nvim',
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
    },
    {
        'ThePrimeagen/harpoon',
    },

    -- Syntax Highlighting & Code Understanding
    {
        'nvim-treesitter/nvim-treesitter',
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
    },

    -- Debugging
    {
        'mfussenegger/nvim-dap',
    },
    {
        'rcarriga/nvim-dap-ui',
    },

    -- Key Mapping Help
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {},
    },

    -- Git Tools
    {
        "kdheepak/lazygit.nvim",
    },
    {
        'lewis6991/gitsigns.nvim',
        as = 'gitsigns',
    },

    -- Editing Tools
    {
        'mbbill/undotree',
    },
    {
        'cohama/lexima.vim',
    },
    {
        'echasnovski/mini.surround',
        version = '*'
    },
    {
        'echasnovski/mini.ai',
        version = '*'
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
    {
        'aznhe21/actions-preview.nvim',
        config = function()
            vim.keymap.set({ 'v', 'n' }, '<leader>vc', require('actions-preview').code_actions)
        end,
    },

    -- AI Tools
    {
        'github/copilot.vim',
    },

    -- Clipboard Manager
    {
        'AckslD/nvim-neoclip.lua',
    },

    -- Language Specific
    {
        'buoto/gotests-vim',
    },

    -- Miscellaneous
    {
        'echasnovski/mini.comment',
        version = '*'
    },
    {
        'eandrju/cellular-automaton.nvim',
    },
    {
        'rmagatti/auto-session',
    },
    {
        'm-demare/attempt.nvim',
    },
    {
        'numToStr/FTerm.nvim',
    },
    {
        'djoshea/vim-autoread',
    },
})

-- REMAPS
local wk = require("which-key")
vim.g.mapleader = ' '
wk.register({
    ["<leader>"] = {
        pv = { vim.cmd.Ex, "Ex command" },
        q = { ":set wrap!<CR>", "Toggle wrap" },
        w = { "<C-w>", "Window operations" },
        k = { "<cmd>lnext<CR>zz", "Next location" },
        j = { "<cmd>lprev<CR>zz", "Previous location" },
    },
    ["<C-s>"] = { vim.cmd.w, "Save" },
    ["<C-d>"] = { '<C-d>zz', "Half-page down" },
    ["<C-u>"] = { '<C-u>zz', "Half-page up" },
    n = { 'nzzzv', "Search forward" },
    N = { 'Nzzzv', "Search backward" },
    zx = { 'zz', "Center line" },
    ["<C-k>"] = { "<cmd>cnext<CR>zz", "Next quickfix" },
    ["<C-j>"] = { "<cmd>cprev<CR>zz", "Previous quickfix" },
    ["<A-a>"] = { ":qa<CR>", "Quit all" },
    ["<A-w>"] = { ":wa<CR>", "Write all" },
}, { mode = "n", prefix = "" })

wk.register({
    ["<C-s>"] = { vim.cmd.w, "Save" },
    Q = { "<nop>", "Disable Q key" },
    ["<A-a>"] = { ":qa<CR>", "Quit all" },
    ["<A-w>"] = { ":wa<CR>", "Write all" },
}, { mode = "v", prefix = "" })

wk.register({
    J = { ":m '>+1<CR>gv=gv", "Move lines down" },
    K = { ":m '>-2<CR>gv=gv", "Move lines up" },
}, { mode = "v", prefix = "" })

wk.register({
    ["<C-c>"] = { "<Esc>", "Exit insert mode" },
}, { mode = "i", prefix = "" })

wk.register({
    ["<leader>p"] = { "|_dP", "Paste over selected text" },
}, { mode = "x", prefix = "" })

require('dikka.substitute')

-- PLUGINS CONFIGS
require("tokyonight").setup({
    style = 'night',
})
vim.cmd [[colorscheme tokyonight]]

-- telescope
require('telescope').setup {
    defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
            i = {
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                ['<C-x>'] = 'select_vertical'
            }
        }
    },
}

local tele = require('telescope.builtin')
local tele_actions = require('telescope.actions')
wk.register({
    p = {
        name = "Project files",
        f = { tele.find_files, "Find Files" },
        s = { tele.live_grep, "Live Grep" },
        g = { tele.git_files, "Git Files" },
    }
}, { mode = "n", prefix = "<leader>" })

-- treesitter
require 'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { "markdown", "javascript", "go", "rust", "typescript", "c", "lua", "vim", "vimdoc", "query" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}

-- lsp-zero
local lsp = require('lsp-zero').preset({
    manage_nvim_cmp = {
        set_sources = 'recommended',
        set_extra_mappings = false,
    }
})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    local opts = { buffer = bufnr }

    wk.register({
        gd = { function() vim.lsp.buf.definition() end, "Go to Definition" },
        K = { function() vim.lsp.buf.hover() end, "Hover Documentation" },
        ["]d"] = { function() vim.diagnostic.goto_next() end, "Next Diagnostic" },
        ["[d"] = { function() vim.diagnostic.goto_prev() end, "Previous Diagnostic" },
        ["<leader>r"] = { ":LspRestart<CR>", "Restart LSP" },
        v = {
            name = "LSP Things",
            w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
            d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
            r = { "<cmd>TroubleToggle lsp_references<cr>", "LSP References" },
            c = { require('actions-preview').code_actions, "Code Actions" },
            n = { function() vim.lsp.buf.rename() end, "Rename Symbol" },
        },
        f = { function() vim.lsp.buf.format({ async = false, timeout_ms = 10000 }) end, "Format Buffer" },
    }, { mode = "n", prefix = "<leader>" })

    wk.register({
        ["<C-h>"] = { function() vim.lsp.buf.signature_help() end, "Signature Help" },
    }, { mode = "i", prefix = "" })
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

-- undotree
wk.register({
    u = {"<cmd>UndotreeToggle<cr>", "Toggle Undotree"},
}, { mode = "n", prefix = "<leader>"})

-- lazygit
wk.register({
    lg = {"<cmd>LazyGit<cr>", "LazyGit"},
}, { mode = "n", prefix = "<leader>"})

-- cellular automaton
wk.register({
    m = {"<cmd>CellularAutomaton make_it_rain<CR>", "Make it rain"},
}, { mode = "n", prefix = "<leader>"})

-- harpoon

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

wk.register({
    ["<C-e>"] = {ui.toggle_quick_menu, "Toggle harpoon"},
    ["<C-h>"] = {function() ui.nav_file(1) end, "Navigate to file 1"},
    ["<C-j>"] = {function() ui.nav_file(2) end, "Navigate to file 2"},
    ["<C-k>"] = {function() ui.nav_file(3) end, "Navigate to file 3"},
    ["<C-l>"] = {function() ui.nav_file(4) end, "Navigate to file 4"},
}, { mode = "n", prefix = "" })

wk.register({
    a = {mark.add_file, "Add file to mark"},
}, { mode = "n", prefix = "<leader>" })

-- mini.ai
require('mini.ai').setup()

-- mini.comment
require('mini.comment').setup()

-- gitsigns
require('gitsigns').setup()

-- neoclip
require('neoclip').setup()
require('telescope').load_extension('neoclip')
wk.register({
    c = {"<cmd>Telescope neoclnvim-treesitter/nvim-treesitter-contextip<CR>", "Neoclip"},
}, { mode = "n", prefix = "<leader>"})

-- treesitter-context
require('treesitter-context').setup {
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
}

wk.register({
    ["[c"] = {function() require("treesitter-context").go_to_context() end, "Go to context"},
}, { mode = "n", prefix = "", silent = true })

-- mini-surround
require('mini.surround').setup()

-- auto-session
require("auto-session").setup {
    log_level = "error",

    cwd_change_handling = {
        restore_upcoming_session = true,   -- already the default, no need to specify like this, only here as an example
        pre_cwd_changed_hook = nil,        -- already the default, no need to specify like this, only here as an example
        post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
            require("lualine").refresh()   -- refresh lualine so the new session name is displayed in the status bar
        end,
    },
}

-- telescope select
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

-- attempt
require('attempt').setup()
require('telescope').load_extension 'attempt'
local attempt = require('attempt')

wk.register({
    a = {
        name = "Scratch files",
        n = {attempt.new_select, "New from predefined", silent = true},
        i = {attempt.new_input_ext, "Custom extension", silent = true},
        r = {attempt.run, "Run scractch file", silent = true},
        d = {attempt.delete_buf, "Delete scratch file", silent = true},
        c = {attempt.rename_buf, "Rename scratch file", silent = true},
        l = {":Telescope attempt<CR>", "Search through sratch files", silent = true},
    }
}, { mode = "n", prefix = "<leader>" })

-- FTerm
require("FTerm").setup({
    dimensions = {
        height = 0.85,
        width = 0.85,
    },
    border = 'double'
})
wk.register({
    ["<A-z>"] = {"<CMD>lua require('FTerm').toggle()<CR>", "Toggle FTerm"},
}, { mode = "n", prefix = "" })

wk.register({
    ["<A-z>"] = {"<C-\\><C-n><CMD>lua require('FTerm').toggle()<CR>", "Toggle FTerm"},
}, { mode = "t", prefix = "" })

-- telescope-file-browser
require("telescope").setup {
    extensions = {
        file_browser = {
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            -- mappings = {
            --   ["i"] = {
            --     -- your custom insert mode mappings
            --   },
            --   ["n"] = {
            --     -- your custom normal mode mappings
            --   },
            -- },
        },
    },
}
require("telescope").load_extension "file_browser"
wk.register({
    pv = {":Telescope file_browser path=%:p:h select_buffer=true<CR>", "File browser"},
}, { mode = "n", prefix = "<space>", noremap = true })

-- DAP
require("dikka.debugger")
