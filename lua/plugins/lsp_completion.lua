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

            "Hoffs/omnisharp-extended-lsp.nvim",
        },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            local lspconfig = require("lspconfig")

            local default_on_attach = function(client, bufnr, disable_semantic_tokens)
                local opts = { buffer = bufnr, silent = true }
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

                if disable_semantic_tokens then
                    client.server_capabilities.semanticTokensProvider = nil
                end
            end

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    default_on_attach(client, bufnr, false)
                end,
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

    --             ◍ python-lsp-server pylsp
    -- ◍ gopls
    -- ◍ kotlin-language-server kotlin_language_server
    -- ◍ lemminx
    -- ◍ lua-language-server lua_ls
    -- ◍ pylyzer
    -- ◍ pyre
    -- ◍ templ


            lspconfig.pylsp.setup({
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    default_on_attach(client, bufnr, false)
                end,
            })
            lspconfig.pylyzer.setup({
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    default_on_attach(client, bufnr, false)
                end,
            })
            lspconfig.pyre.setup({
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    default_on_attach(client, bufnr, false)
                end,
            })

            lspconfig.lemminx.setup({
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    default_on_attach(client, bufnr, false)
                end,
            })

            lspconfig.gopls.setup({
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    default_on_attach(client, bufnr, false)
                end,
            })

            lspconfig.templ.setup({
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    default_on_attach(client, bufnr, false)
                end,
            })

            lspconfig.tinymist.setup({
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    default_on_attach(client, bufnr, false)
                end,
            })

            lspconfig.omnisharp.setup({
                capabilities = capabilities,
                cmd = { "/home/dikka/.local/share/nvim/mason/packages/omnisharp/omnisharp", }, -- doesn't work without this...
                on_attach = function(client, bufnr)
                    local opts = { buffer = bufnr, silent = true }
                    local keymap = vim.keymap.set

                    keymap("n", "gd", require("omnisharp_extended").lsp_definition, opts)
                    keymap("n", "gD", function()
                        vim.cmd("tab split")
                        require("omnisharp_extended").lsp_definition()
                    end, opts)
                    keymap("n", "<leader>vr", require("omnisharp_extended").lsp_references, opts)
                    keymap("n", "<leader>vi", require("omnisharp_extended").lsp_implementation, opts)
                    -- + all the other non specific ones
                    keymap("n", "]d", vim.diagnostic.goto_next, opts)
                    keymap("n", "[d", vim.diagnostic.goto_prev, opts)
                    keymap("n", "K", vim.lsp.buf.hover, opts)
                    keymap("n", "<leader>vc", vim.lsp.buf.code_action, opts)
                    keymap("n", "<leader>vn", vim.lsp.buf.rename, opts)
                    keymap("n", "<leader>f", vim.lsp.buf.format, opts)
                    keymap("i", "<C-h>", vim.lsp.buf.signature_help, opts)
                end,
            })

            lspconfig.buf_ls.setup({
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    default_on_attach(client, bufnr, true)
                end,
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
                preset = "luasnip",
            },
            sources = {
                default = { "lsp", "path", "buffer" },
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
