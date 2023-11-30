local dap, dapui = require("dap"), require("dapui")
dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

vim.fn.sign_define('DapBreakpoint', { text = '⛔', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '💤', texthl = '', linehl = '', numhl = '' })

local wk = require('which-key')

wk.register({
    ["<F9>"] = { require 'dap'.continue, "dap continue" },
    ["<F8>"] = { require 'dap'.step_over, "dap step over" },
    ["<F7>"] = { require 'dap'.step_into, "dap step into" },
    ["<F6>"] = { require 'dap'.step_out, "dap step out" },
}, { mode = "n", prefix = "" })

wk.register({
    d = {
        name = 'Debug',
        t = { '<cmd>lua require("dapui").toggle()<CR>', 'Toggle UI' },
        b = { '<cmd>lua require("dap").toggle_breakpoint()<CR>', 'Toggle breakpoint' },
        r = { '<cmd>lua require("dap").repl.open()<CR>', 'Open REPL' },
        l = { '<cmd>lua require("dap").run_last()<CR>', 'Run last' },
        h = { '<cmd>lua require("dap.ui.widgets").hover()<CR>', 'Hover' },
        p = { '<cmd>lua require("dap.ui.widgets").preview()<CR>', 'Preview' },
        f = { '<cmd>lua require("dap.ui.widgets").centered_float(require("dap.ui.widgets").frames)<CR>', 'Frames' },
        s = { '<cmd>lua require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes)<CR>', 'Scopes' },
    }
}, { prefix = '<leader>' })


-- GOLANG
dap.adapters.delve = {
    type = 'server',
    port = '${port}',
    executable = {
        command = 'dlv',
        args = { 'dap', '-l', '127.0.0.1:${port}' },
    }
}

dap.configurations.go = {
    {
        type = "delve",
        name = "Debug",
        request = "launch",
        program = "${file}"
    },
    {
        type = "delve",
        name = "Debug (go.mod)",
        request = "launch",
        program = "./${relativeFileDirname}"
    },
    {
        type = "delve",
        name = "Debug test", -- configuration for debugging test files
        request = "launch",
        mode = "test",
        program = "${file}"
    },
    -- works with go.mod packages and sub packages
    {
        type = "delve",
        name = "Debug test (go.mod)",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}"
    }
}
