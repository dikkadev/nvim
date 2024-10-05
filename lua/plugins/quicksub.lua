return {
    {
        'sett17/quicksub.nvim',
        as = 'quicksub',
        keys = {
            { '<leader>s', function() require('quicksub.quicksub').quicksub() end, mode = 'v', desc = 'QuickSub' },
        },
    },
}
