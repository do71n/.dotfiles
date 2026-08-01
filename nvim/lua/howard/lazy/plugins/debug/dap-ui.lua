return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
    },

    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        -- setup DAP UI
        dapui.setup() -- use default config

        -- UI toggle
        dap.listeners.before.attach.dapui_config = function() dapui.open() end
        dap.listeners.before.launch.dapui_config = function() dapui.open() end
        dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
        dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

        vim.keymap.set("n", "<leader>du", function() dapui.toggle() end, { desc = "Debug: Toggle UI" })

        -- Add the word under cursor to DAP watch
        vim.keymap.set("n", "<leader>dwp", function()
            local expression = vim.fn.input("Watch expression: ")
            if expression ~= "" then
                dapui.elements.watches.add(expression)
            end
        end, { desc = "Add variable to Watch" })

        vim.keymap.set("n", "<leader>dW", function ()
            local ft = vim.bo.filetype
            if ft ~= "dapui_watches" then
                vim.notify("Open UI and focus watches element first", vim.log.levels.WARN)
                return
            end
            dapui.elements.watches.remove()
        end, { desc = "Remove variable from Watch" })

    end
}
