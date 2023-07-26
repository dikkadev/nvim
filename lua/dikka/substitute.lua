-- Define the function separately
local function my_substitute()
    -- Start undo block
    vim.cmd('normal! u')

    -- Save the current register and clipboard settings
    local old_reg = vim.fn.getreg('"')
    local old_clipboard = vim.o.clipboard

    -- Don't allow system clipboard to be affected
    vim.o.clipboard = ''

    -- Visually select the previously visually-selected text and yank it
    vim.cmd('normal! gv"xy')

    -- Get the yanked text from the unnamed register
    local selected_text = vim.fn.getreg('"')

    -- Restore the old register and clipboard settings
    vim.fn.setreg('"', old_reg)
    vim.o.clipboard = old_clipboard

    -- End undo block
    vim.cmd('normal! u')

    vim.cmd('normal! <C-c>') -- Go back to normal mode

    -- Escape special characters
    selected_text = selected_text:gsub("([%.%*%\\%/[%]{}%^%$|])", "\\%1")
    selected_text = selected_text:gsub("\n", "\\n")
    selected_text = selected_text:gsub("/", "\\/")

    local range = vim.fn.input("Enter the range offset: ")
    local command_start = ':'

    if range == '%' then
        command_start = command_start .. '%'
    else
        if tonumber(range) ~= nil then
            command_start = command_start .. ',+' .. range
        else
            command_start = command_start .. ',' .. range
        end
    end

    local command = command_start .. "s/\\(" .. selected_text .. "\\)//gi"
    print(command)

    -- Simulate typing the command into the command-line, but don't execute it
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(command .. "<Left><Left><Left>", true, true, true), 'n',
        false)
end

-- Register with which-key
local wk = require("which-key")
wk.register({
    ["<leader>s"] = { my_substitute, "Substitute selection" },
}, { mode = "v", prefix = "" })
