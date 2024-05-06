return {
  "mfussenegger/nvim-dap",
  dependencies = {
    -- Creates a beautiful debugger UI
    "rcarriga/nvim-dap-ui",

    -- Required dependency for nvim-dap-ui
    "nvim-neotest/nvim-nio",
    -- Add your own debuggers here
    -- 'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require "dap"
    local dapui = require "dapui"

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}", --let both ports be the same for now...
      executable = {
        -- command = "node",
        -- args = { vim.fn.stdpath('data') .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
        command = "js-debug-adapter",
        args = { "${port}" },
      },
    }

    for _, language in ipairs { "typescript", "javascript" } do
      dap.configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch Current File (pwa-node)",
          cwd = "${workspaceFolder}", -- vim.fn.getcwd(),
          args = { "${file}" },
          sourceMaps = true,
          protocol = "inspector",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Debug Mocha Tests",
          -- trace = true, -- include debugger info
          runtimeExecutable = "yarn",
          runtimeArgs = { "test" },
          cwd = vim.fn.getcwd(),
          -- sourceMaps = true,
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch Current File (Typescript)",
          cwd = "${workspaceFolder}",
          runtimeArgs = { "--import tsx" },
          program = "${file}",
          runtimeExecutable = "node",
          -- args = { '${file}' },
          sourceMaps = true,
          protocol = "inspector",
          outFiles = { "${workspaceFolder}/**/**/*", "!**/node_modules/**" },
          skipFiles = { "<node_internals>/**", "node_modules/**" },
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
        },
      }
    end

    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close

    -- Install golang specific config
    -- require('dap-go').setup()
  end,
}
