return {
    {
        'chrishrb/gx.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = { 'Browse' },
        init = function(_)
            vim.g.netrw_nogx = 1
        end,
        submodules = false,
        config = function()
            require('gx').setup {
                open_browser_app = '/home/dikka/chrome_incognito.sh',
                open_browser_arg = { '--new-window' },
            }
        end,
        keys = {
            { 'gx', '<cmd>Browse<cr>', mode = { 'n', 'x' }, desc = 'Browse' },
        },
    },
}
