return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    -- Optional: If you use Mason to manage adapters
    -- "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- Optional: If using mason-nvim-dap, setup integration
    -- require('mason-nvim-dap').setup({
    --   ensure_installed = { 'coreclr', 'codelldb', 'node-debug2-adapter' }, -- Add node adapter here
    --   handlers = {}, -- Optional: Let mason-nvim-dap setup default handlers
    -- })

    -- ===== Adapters =====

    -- .NET Core / C# Adapter
    dap.adapters.coreclr = {
      type = "executable",
      -- Ensure netcoredbg is installed and in your PATH
      command = "/bin/netcoredbg", -- Adjust path if necessary
      args = { "--interpreter=vscode" },
    }

    -- C / C++ / Rust / Assembly Adapter (using codelldb)
    dap.adapters.lldb = {
      type = 'executable',
      -- Ensure codelldb is installed (e.g., via Mason) and in your PATH
      command = 'codelldb',
      name = 'lldb'
    }

    -- Node.js Debug Adapter (node-debug2)
    dap.adapters.node2 = {
      type = 'executable',
      -- Ensure node-debug2-adapter is installed (e.g., via Mason) and in your PATH
      command = 'node-debug2-adapter',
      name = 'node2' -- You can name this whatever you like, e.g., 'node'
                     -- but ensure it matches the 'type' in configurations below
    }


    -- ===== Configurations =====

    -- C# Configuration
    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
          return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
        end,
      },
    }

    -- C / Assembly Configuration
    dap.configurations.c = {
      {
        name = "Launch C/Assembly Program (lldb)",
        type = "lldb", -- Refers to the dap.adapters.lldb entry
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = true, -- Set to false if you don't want to stop at the entry point
        args = {},
        runInTerminal = false, -- Set to true to run in an external terminal
      },
    }
    dap.configurations.asm = dap.configurations.c -- Reuse C config for Assembly


    -- JavaScript / Node.js Configurations
    -- dap.configurations.javascript = {
    --   {
    --     name = 'Launch Node Program',
    --     type = 'node2', -- Refers to the dap.adapters.node2 entry
    --     request = 'launch',
    --     program = '${workspaceFolder}/index.js', -- Default entry point, adjust as needed
    --     cwd = '${workspaceFolder}',
    --     sourceMaps = true, -- Enable source maps if you're using transpilers (like Babel or TypeScript)
    --     protocol = 'inspector',
    --     console = 'internalConsole', -- Show console output in DAP repl
    --   },
    --   {
    --     name = 'Attach to Node Process',
    --     type = 'node2', -- Refers to the dap.adapters.node2 entry
    --     request = 'attach',
    --     processId = require('dap.utils').pick_process, -- Helper to select running node process
    --     cwd = '${workspaceFolder}',
    --     sourceMaps = true,
    --     protocol = 'inspector',
    --   },
    --   -- Add more specific configurations if needed, e.g., for specific scripts
    --   {
    --     name = 'Launch Current File (Node)',
    --     type = 'node2',
    --     request = 'launch',
    --     program = '${file}', -- Debug the currently open file
    --     cwd = '${workspaceFolder}',
    --     sourceMaps = true,
    --     protocol = 'inspector',
    --     console = 'internalConsole',
    --   },
    -- }
    --
    -- -- TypeScript Configuration (often similar to JavaScript)
    -- dap.configurations.typescript = {
    --   {
    --     name = 'Launch TypeScript Program',
    --     type = 'node2', -- Reuse the node2 adapter
    --     request = 'launch',
    --     -- Often you compile TS to JS in a 'dist' folder
    --     program = '${workspaceFolder}/dist/index.js', -- Adjust path to compiled JS
    --     -- Or if using ts-node for direct execution (requires ts-node to be installed):
    --     -- program = '${workspaceFolder}/src/index.ts', -- Entry TS file
    --     -- runtimeArgs = { "-r", "ts-node/register" },
    --     cwd = '${workspaceFolder}',
    --     sourceMaps = true, -- Crucial for mapping compiled JS back to TS
    --     protocol = 'inspector',
    --     console = 'internalConsole',
    --     outFiles = { "${workspaceFolder}/dist/**/*.js" }, -- Help debugger find compiled output
    --   },
    --   {
    --     name = 'Attach to TypeScript Process',
    --     type = 'node2',
    --     request = 'attach',
    --     processId = require('dap.utils').pick_process,
    --     cwd = '${workspaceFolder}',
    --     sourceMaps = true,
    --     protocol = 'inspector',
    --     outFiles = { "${workspaceFolder}/dist/**/*.js" },
    --   },
    --    {
    --     name = 'Launch Current File (ts-node)', -- Requires ts-node
    --     type = 'node2',
    --     request = 'launch',
    --     args = {"${file}"},
    --     runtimeArgs = {"-r", "ts-node/register"},
    --     runtimeExecutable = "node",
    --     cwd = '${workspaceFolder}',
    --     sourceMaps = true,
    --     protocol = 'inspector',
    --     console = 'internalConsole',
    --   },
    -- }

    -- ===== DAP UI Setup and Listeners =====

    dapui.setup() -- Default setup

    -- Open/Close UI automatically
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- ===== Keymaps =====
    vim.keymap.set("n", "<Leader>dt", function() dap.toggle_breakpoint() end, { desc = "DAP: Toggle Breakpoint" })
    vim.keymap.set("n", "<Leader>dc", function() dap.continue() end, { desc = "DAP: Continue" })
    vim.keymap.set("n", "<Leader>do", function() dap.step_over() end, { desc = "DAP: Step Over" })
    vim.keymap.set("n", "<Leader>di", function() dap.step_into() end, { desc = "DAP: Step Into" })
    vim.keymap.set("n", "<Leader>du", function() dap.step_out() end, { desc = "DAP: Step Out" })
    vim.keymap.set("n", "<Leader>dr", function() dap.repl.open() end, { desc = "DAP: Open REPL" })
    vim.keymap.set("n", "<Leader>dl", function() dap.run_last() end, { desc = "DAP: Run Last" })
    vim.keymap.set("n", "<Leader>dd", function() dap.disconnect() end, { desc = "DAP: Disconnect" })
    vim.keymap.set("n", "<Leader>d?", function()
        require('dapui').eval(nil, { enter = true })
    end, { desc = "DAP: Evaluate Expression" })

  end,
}
