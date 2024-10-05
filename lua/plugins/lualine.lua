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
            },
        },
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    },
}
