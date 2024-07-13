return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-lua/plenary.nvim",
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
    local Job = require "plenary.job"

    -- local function pick_project_process()
    --   local cwd = vim.fn.getcwd()
    --
    --   local jobs = Job:new {
    --     command = "ps",
    --     args = { "-eo", "pid,command" },
    --     on_exit = function(j, return_val)
    --       if return_val ~= 0 then
    --         print "Error running ps command"
    --         return
    --       end
    --
    --       local result = j:result()
    --       local processes = {}
    --
    --       for _, line in ipairs(result) do
    --         local pid, cmd = line:match "^(%d+)%s+(.+)$"
    --         if pid and cmd then
    --           if cmd:find(cwd, 1, true) then table.insert(processes, { pid = pid, command = cmd }) end
    --         end
    --       end
    --
    --       if #processes == 0 then
    --         print "No matching processes found"
    --         return
    --       end
    --
    --       local opts = {
    --         prompt = "Select process: ",
    --         format_item = function(item) return string.format("%s (%s)", item.pid, item.command) end,
    --       }
    --
    --       local function on_choice(item, _)
    --         if not item then
    --           print "No process selected"
    --           return
    --         end
    --         dap.run {
    --           type = "pwa-node",
    --           request = "attach",
    --           name = "Attach",
    --           processId = item.pid,
    --           cwd = cwd,
    --           sourceMaps = true,
    --         }
    --       end
    --
    --       vim.ui.select(processes, opts, on_choice)
    --     end,
    --   }
    --
    --   jobs:start()
    -- end
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
          -- cwd = "${workspaceFolder}",
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
