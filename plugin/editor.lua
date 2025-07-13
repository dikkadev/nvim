local opt = vim.opt

opt.clipboard = 'unnamedplus'

opt.nu = true
opt.relativenumber = true

opt.cursorline = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

opt.ignorecase = true
opt.hlsearch = false
opt.incsearch = true
opt.wrapscan = true

opt.wrap = true

opt.inccommand = 'split'

-- opt.signcolumn = 'number'

opt.scrolloff = 24
opt.sidescrolloff = 8

opt.updatetime = 500

opt.autoread = true
opt.splitright = true
opt.splitbelow = true

vim.o.showbreak = '⏎'

opt.spelllang = 'en_us'
opt.spell = true

opt.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . '  ' . (v:foldend - v:foldstart + 1)]]
opt.foldlevelstart = 99
opt.fillchars = "fold: "
opt.foldnestmax = 3
opt.foldminlines = 1
