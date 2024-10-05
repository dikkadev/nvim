return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

      -- "nvim-telescope/telescope-smart-history.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "kkharji/sqlite.lua",
    },
    opts = {
        pickers = {
            find_files = {
                hidden = true,
            },
        },
        extensions = {
            wrap_results = true,

            fzf = {},
            -- history = {
            --   path = '~/.local/share/nvim/telescope_history.db',
            --   limit = 100,
            -- },
            ["ui-select"] = {
              require("telescope.themes").get_dropdown {},
            },
        },
        defaults = {
            file_ignore_patterns = { '.git' },
            mappings = {
                i = {
                    ['<C-x>'] = 'select_vertical'
                }
            }
        },
    },
    config = function()
        pcall(require("telescope").load_extension, "fzf")
        -- pcall(require("telescope").load_extension, "smart_history")
        pcall(require("telescope").load_extension, "ui-select")
    end,
    keys = {
        { '<leader>pf', require('telescope.builtin').find_files, desc = 'Find files' },
        { '<leader>ps', require('telescope.builtin').live_grep,  desc = 'Find in files' },
        { '<leader>pg', require('telescope.builtin').git_files,  desc = 'Find git files' },
        { '<leader>ph', require('telescope.builtin').help_tags,  desc = 'Find help tags' },
    }
  }
}
