return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio"
        },
        config = function()
            local dapui = require("dapui")
            local dap = require("dap")

            dapui.setup()
            -- 1. Setup the Adapter (codelldb), This assumes you installed codelldb via :Mason
            dap.adapters.codelldb = {
                type = 'server',
                port = "${port}",
                executable = {
                    -- Change this to your installation path if not using Mason
                    command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
                    args = { "--port", "${port}" },
                },
            }

            dap.configurations.c = {
                {
                    name = "Launch file",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        -- Asks you for the path to the executable
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                    -- If you need to pass arguments to your C program, add them here:
                    -- args = {"arg1", "arg2"},
                    args = {},
                },
            }

            --Set the keymaps
            --Manual UI Toggle Keymap and Input the executable
            vim.keymap.set('n', '<leader>du', function() dapui.toggle() end, { desc = "Debug: Toggle UI" })

            --Standard Debugging Keymaps
            vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end, { desc = "Debug: Breakpoint" })
            vim.keymap.set('n', '<leader>dc', function() dap.continue() end, { desc = "Debug: Start/Continue" })
            vim.keymap.set('n', '<leader>dr', function() dap.restart() end, { desc = "Debug: Restart" })
            vim.keymap.set('n', '<leader>dt', function() dap.terminate() end, { desc = "Debug: Terminate" })
            vim.keymap.set('n', '<leader>so', function() dap.step_over() end, { desc = "Debug: Step Over" })
            vim.keymap.set('n', '<leader>su', function() dap.step_out() end, { desc = "Debug: Step out" })
            vim.keymap.set('n', '<leader>si', function() dap.step_into() end, { desc = "Debug: Step Into" })
            vim.keymap.set('n', '<leader>sb', function() dap.step_back() end, { desc = "Debug: Step Back" })

            vim.keymap.set('n', '<leader>B', function()
                dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
            end, { desc = "Debug: Set Conditional Breakpoint" })
            -- Add the word under cursor to DAP watch
            vim.keymap.set('n', '<leader>dwp', function()
                require("dapui").elements.watches.add()
            end, { desc = "Add variable to Watch" })

            --Optional: Reset UI on exit (without opening it automatically)
            dap.listeners.before.attach.dapui_config = function() dapui.open() end
            dap.listeners.before.launch.dapui_config = function() dapui.open() end
            dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
            dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

        end
    }
}
