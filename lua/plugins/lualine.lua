return {
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
                lualine_x = {
                    function()
                        local wc = vim.fn.wordcount()
                        local words = wc.visual_words or wc.words
                        local chars = wc.visual_chars or wc.chars
                        return string.format("%dW %dC", words or 0, chars or 0)
                    end,
                },
            },
        },
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    },
}
