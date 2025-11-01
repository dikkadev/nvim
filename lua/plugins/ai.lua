local plugins = {
    -- GitHub Copilot
    {
        'github/copilot.vim',
        init = function(_)
            vim.g.copilot_filetypes = { markdown = true }
        end
    },

    -- OpenCode.nvim - Integrates opencode AI assistant with Neovim
    {
        "NickvanDyke/opencode.nvim",
        dependencies = {
            -- Required for default `toggle()` implementation
            { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
        },
        config = function()
            local opencode = require("opencode")
            local snacks = require("snacks")

            -- Track terminal window for sidebar mode
            local sidebar_term_win = nil

            -- Provider for sidebar mode (vertical split)
            local function sidebar_provider()
                return {
                    toggle = function(self)
                        if sidebar_term_win and vim.api.nvim_win_is_valid(sidebar_term_win) then
                            -- Close sidebar
                            vim.api.nvim_win_close(sidebar_term_win, true)
                            sidebar_term_win = nil
                        else
                            -- Open sidebar (vertical split on right)
                            vim.cmd("vsplit")
                            vim.cmd("vertical resize 80")
                            local win = vim.api.nvim_get_current_win()
                            sidebar_term_win = win
                            snacks.terminal.open({}, function(term)
                                vim.cmd("opencode")
                            end)
                        end
                    end,
                    start = function(self)
                        if not sidebar_term_win or not vim.api.nvim_win_is_valid(sidebar_term_win) then
                            vim.cmd("vsplit")
                            vim.cmd("vertical resize 80")
                            sidebar_term_win = vim.api.nvim_get_current_win()
                            snacks.terminal.open({}, function(term)
                                vim.cmd("opencode")
                            end)
                        end
                    end,
                    show = function(self)
                        if sidebar_term_win and vim.api.nvim_win_is_valid(sidebar_term_win) then
                            vim.api.nvim_set_current_win(sidebar_term_win)
                        end
                    end,
                }
            end

            -- Default provider (sidebar mode - what actually works)
            local default_provider = sidebar_provider()

            ---@type opencode.Opts
            vim.g.opencode_opts = {
                provider = default_provider,
                -- Auto-reload buffers when opencode edits files
                auto_reload = true,
            }

            -- Required for `opts.auto_reload` feature
            vim.o.autoread = true

            -- Keybindings with <leader>a chain
            -- Register group name for which-key (if available)
            pcall(function()
                local wk = require("which-key")
                wk.add({
                    { "<leader>a", group = "opencode" },
                })
            end)

            -- Primary keybindings
            vim.keymap.set({ "n", "x", "v" }, "<leader>ai", function() opencode.ask() end, { desc = "Ask (interactive)" })
            vim.keymap.set({ "n", "x", "v" }, "<leader>ap", function() opencode.prompt("@this") end,
                { desc = "Prompt @this" })
            vim.keymap.set({ "n", "x", "v" }, "<leader>ag", function() opencode.select() end, { desc = "Select action" })

            -- Window management
            vim.keymap.set({ "n", "x", "v" }, "<leader>at", function() opencode.toggle() end, { desc = "Toggle sidebar" })
        end,
    },
}

-- Augment Code (conditional loading)
local should_load_augment_code = os.getenv("NVIM_AUGMENT_CODE") == "true"
if should_load_augment_code then
    table.insert(plugins, {
        "augmentcode/augment.vim",
    })
end

return plugins
