local opts = { noremap = true, silent = true }
local map = function(mode, key, cmd)
    vim.api.nvim_buf_set_keymap(0, mode, key, cmd, opts)
end

map("n", "<leader>gi", "<cmd>GoImpl<CR>")
map("n", "<leader>ge", "<cmd>GoIfErr<CR>")
map("n", "<leader>gc", "<cmd>GoCmt<CR>")
map("n", "<leader>gff", ":GoFillStruct<CR>")
map("n", "<leader>gfs", ":GoFillSwitch<CR>")
map("n", "<leader>gfp", ":GoFixPlurals<CR>")
map("n", "<leader>gt", ":GoAddTest<CR>")
map("n", "<leader>gT", ":GoAddAllTest<CR>")
map("n", "<leader>ga", ":GoAlt!<CR>")

local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        require('go.format').goimports()
    end,
    group = format_sync_grp,
})
