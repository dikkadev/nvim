
return {
    {
        'AndrewRadev/switch.vim',
        keys = {
            { '<leader>s', ':Switch<CR>',        desc = 'Switch' },
            { '<leader>S', ':SwitchReverse<CR>', desc = 'Switch reverse' },
        },
        config = function()
            vim.g['switch_mapping'] = "<leader>s"
            vim.g['switch_definitions'] = {
                vim.fn['switch#NormalizedCaseWords'] { 'sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday' },
                vim.fn['switch#NormalizedCase'] { 'true', 'false' },
                vim.fn['switch#NormalizedCase'] { 'HIGH', 'LOW' },
                vim.fn['switch#NormalizedCase'] { 'yes', 'no' },
                vim.fn['switch#NormalizedCase'] { 'on', 'off' },
                vim.fn['switch#NormalizedCase'] { 'and', 'or' },
                vim.fn['switch#NormalizedCase'] { '0x00', '0x01' },
                vim.fn['switch#NormalizedCase'] { 'left', 'right', 'down', 'up' },
                vim.fn['switch#NormalizedCase'] { 'enable', 'disable' },
                vim.fn['switch#NormalizedCase'] { 'not', '/*not*/' },
                { '==', '!=' },
                { '&&', '||' },
                {
                    ["\\<\\(\\l\\)\\(\\l\\+\\(\\u\\l\\+\\)\\+\\)\\>"] = "\\=toupper(submatch(1)) . submatch(2)",        -- Convert camelCase to CamelCase
                    ["\\<\\(\\u\\l\\+\\)\\(\\u\\l\\+\\)\\+\\>"] =
                    "\\=tolower(substitute(submatch(0), '\\(\\l\\)\\(\\u\\)', '\\1_\\2', 'g'))",                        -- Convert CamelCase to snake_case
                    ["\\<\\(\\l\\+\\)\\(_\\l\\+\\)\\+\\>"] = "\\U\\0",                                                  -- Convert snake_case to SCREAMING_SNAKE_CASE
                    ["\\<\\(\\u\\+\\)\\(_\\u\\+\\)\\+\\>"] = "\\=tolower(substitute(submatch(0), '_', '-', 'g'))",      -- Convert SCREAMING_SNAKE_CASE to kebab-case
                    ["\\<\\(\\l\\+\\)\\(-\\l\\+\\)\\+\\>"] = "\\=substitute(submatch(0), '-\\(\\l\\)', '\\u\\1', 'g')", -- Convert kebab-case to camelCase
                },
                {                                                                                                       -- Markdown task list
                    ["\\v^\\(\\s*\\)- \\[ \\] \\(.*\\)"] = "\\1- [x] \\2",
                    ["\\v^\\(\\s*\\)- \\[x\\] \\(.*\\)"] = "\\1- [ ] \\2",
                }
            }
        end,
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
}
