return {
    {
        'chentoast/marks.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            default_mappings = false,
            cyclic = true,
            force_write_shada = false,
        },
    },
}
