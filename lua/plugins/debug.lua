return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
    },
    config = function()
      local dap = require "dap"
      local ui = require "dapui"

      require("dapui").setup()
      require("dap-go").setup()

      require("nvim-dap-virtual-text").setup{}

      -- vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
      -- vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

      -- Eval var under cursor
      vim.keymap.set("n", "<space>?", function()
        require("dapui").eval(nil, { enter = true })
      end)

      -- vim.keymap.set("n", "<F1>", dap.continue)
      -- vim.keymap.set("n", "<F2>", dap.step_into)
      -- vim.keymap.set("n", "<F3>", dap.step_over)
      -- vim.keymap.set("n", "<F4>", dap.step_out)
      -- vim.keymap.set("n", "<F5>", dap.step_back)
      -- vim.keymap.set("n", "<F13>", dap.restart)

      vim.keymap.set("n", "<leader>dt", dap.continue)
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
      vim.keymap.set("n", "<leader>dg", dap.run_to_cursor)
      vim.keymap.set("n", "<leader>dc", dap.continue)
      vim.keymap.set("n", "<leader>dso", dap.step_over)
      vim.keymap.set("n", "<leader>dsi", dap.step_into)
      vim.keymap.set("n", "<leader>dsr", dap.step_out)
      vim.keymap.set("n", "<leader>dr", dap.restart)
      vim.keymap.set("n", "<leader>dur", function () ui.open({reset = true}) end)
      vim.keymap.set("n", "<leader>dui", function () ui.toggle() end)

      -- dap.listeners.before.attach.dapui_config = function()
      --   ui.open()
      -- end
      -- dap.listeners.before.launch.dapui_config = function()
      --   ui.open()
      -- end
      -- dap.listeners.before.event_terminated.dapui_config = function()
      --   ui.close()
      -- end
      -- dap.listeners.before.event_exited.dapui_config = function()
      --   ui.close()
      -- end
    end,
  },
}
