-- REMAPS
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<C-s>", vim.cmd.w)

-- CONFIGS
vim.opt.clipboard = 'unnamedplus'
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.inccommand = "nosplit"

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.singcolumn = "yes:1"

vim.opt.updatetime = 500

vim.opt.colorcolumn = 80

-- LAZY
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  print('Installing lazy.nvim....')
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
  print('Done.')
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	{
		'rose-pine/neovim',
		name = 'rose-pine'
	},
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		dependencies = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{                                      -- Optional
			'williamboman/mason.nvim',
			build = function()
				pcall(vim.cmd, 'MasonUpdate')
			end,
			},
			{'williamboman/mason-lspconfig.nvim'}, -- Optional

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},     -- Required
			{'hrsh7th/cmp-nvim-lsp'}, -- Required
			{'L3MON4D3/LuaSnip'},     -- Required
		}
	},
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.2',
		-- or                              , branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		'nvim-treesitter/nvim-treesitter',
		{run = ':TSUpdate'}
	},
	{
		'mbbill/undotree',
	},
})

-- PLUGINS CONFIGS

-- rose-pine
vim.cmd('colorscheme rose-pine'

-- telescope
local tele = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', tele.find_files, {})
vim.keymap.set('n', '<C-p>', tele.git_files, {})
vim.keymap.set('n', '<leader>ps', tele.live_grep, {})


-- treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {"javascript", "go", "rust", "typescript", "c", "lua", "vim", "vimdoc", "query" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
