return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        opts = {},
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {},
                automatic_installation = false,
            })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "saghen/blink.cmp",
            "aznhe21/actions-preview.nvim",
            "williamboman/mason.nvim",
        },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            local lspconfig = require("lspconfig")

            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(ev)
                    local opts = { buffer = ev.bufnr, silent = true }
                    local keymap = vim.keymap.set

                    keymap("n", "]d", vim.diagnostic.goto_next, opts)
                    keymap("n", "[d", vim.diagnostic.goto_prev, opts)
                    keymap("n", "gd", vim.lsp.buf.definition, opts)
                    keymap("n", "gD", function()
                        vim.cmd("tab split")
                        vim.lsp.buf.definition()
                    end, opts)
                    keymap("n", "K", vim.lsp.buf.hover, opts)
                    keymap("n", "<leader>vc", vim.lsp.buf.code_action, opts)
                    keymap("n", "<leader>cp", require("actions-preview").code_actions, opts)
                    keymap("n", "<leader>vn", vim.lsp.buf.rename, opts)
                    keymap("n", "<leader>f", vim.lsp.buf.format, opts)
                    keymap("i", "<C-h>", vim.lsp.buf.signature_help, opts)
                end
            })

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        format = {
                            enable = true,
                            defaultConfig = {
                                indent_style = "space",
                                indent_size = "2",
                            }
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                    }
                }
            })

            lspconfig.gopls.setup({
                capabilities = capabilities,
            })

            lspconfig.templ.setup({
                capabilities = capabilities,
            })

            lspconfig.omnisharp.setup({
                capabilities = capabilities,
            })

            lspconfig.buf_ls.setup({
                capabilities = capabilities,
            })

        end,
    },

    {
        "saghen/blink.cmp",
        version = "v0.*",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
        },
        opts = {
            keymap = {
                preset = "default",
                ["<CR>"] = { "fallback" },
            },
            snippets = {
                expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
                active = function(filter)
                    if filter and filter.direction then
                        return require('luasnip').jumpable(filter.direction)
                    end
                    return require('luasnip').in_snippet()
                end,
                jump = function(direction) require('luasnip').jump(direction) end,
            },
            sources = {
                default = { "lsp", "path", "luasnip", "buffer" },
            },
            appearance = {
                use_nvim_cmp_as_default = true,
            },
            completion = {
                documentation = {
                    auto_show = true,         -- show doc automatically
                    auto_show_delay_ms = 500, -- delay before doc shows
                    update_delay_ms = 50,
                },
            },
        },
    },
}
