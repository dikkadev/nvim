return {
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
                    { name = "path" },
                    { name = "buffer" },
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

            -- BEGIN SNIPPET MIGRATION
            -- Added LuaSnip configuration start
            local ls = require "luasnip"

            -- Define snippet expansion and navigation functions
            vim.snippet = {}
            vim.snippet.expand = ls.lsp_expand

            vim.snippet.active = function(filter)
                filter = filter or {}
                filter.direction = filter.direction or 1

                if filter.direction == 1 then
                    return ls.expand_or_jumpable()
                else
                    return ls.jumpable(filter.direction)
                end
            end

            vim.snippet.jump = function(direction)
                if direction == 1 then
                    if ls.expandable() then
                        return ls.expand_or_jump()
                    else
                        return ls.jumpable(1) and ls.jump(1)
                    end
                else
                    return ls.jumpable(-1) and ls.jump(-1)
                end
            end

            vim.snippet.stop = ls.unlink_current

            -- Configure LuaSnip
            ls.config.set_config {
                history = true,
                updateevents = "TextChanged,TextChangedI",
                override_builtin = true,
            }

            -- Load custom snippets
            for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/snippets/*.lua", true)) do
                loadfile(ft_path)()
            end

            -- Set keybindings for snippet navigation
            vim.keymap.set({ "i", "s" }, "<C-l>", function()
                return vim.snippet.active { direction = 1 } and vim.snippet.jump(1)
            end, { silent = true })

            vim.keymap.set({ "i", "s" }, "<C-h>", function()
                return vim.snippet.active { direction = -1 } and vim.snippet.jump(-1)
            end, { silent = true })

            -- Set completion options
            vim.opt.completeopt = { "menu", "menuone", "noselect" }
            vim.opt.shortmess:append "c"
            -- END SNIPPET MIGRATION
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
        end,
    },
}
