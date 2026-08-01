return {
	{
		"mfussenegger/nvim-dap",
		dependencies = { "rcarriga/nvim-dap-ui" },

		config = function()
            local dap = require("dap")

            ------------- dap adapters --------------
            local codelldb = vim.fn.stdpath("data") .. "/mason/bin/codelldb"
            if vim.fn.executable(codelldb) == 0 then
                vim.notify("codelldb not found. Run :MasonInstall codelldb", vim.log.levels.ERROR)
            end

            dap.adapters.codelldb = {
                type = "server",
				port = "${port}",
				executable = {
					-- Change this to your installation path if not using Mason: vim.fn.exepath("codelldb")
					command = codelldb,
					args = { "--port", "${port}" },
				},
			}

            ------------- dap configurations -------------
			dap.configurations.c = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					program = function()
						-- Asks you for the path to the executable
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					-- If you need to pass arguments to your C program, add them here:
					-- args = {"arg1", "arg2"},
					args = {},
				},
			}

			--- Standard Debugging Keymaps
			vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Debug: Breakpoint" })
			vim.keymap.set("n", "<leader>dc", function() dap.continue() end, { desc = "Debug: Start/Continue" })
			vim.keymap.set("n", "<leader>dr", function() dap.restart() end, { desc = "Debug: Restart" })
			vim.keymap.set("n", "<leader>dt", function() dap.terminate() end, { desc = "Debug: Terminate" })
			vim.keymap.set("n", "<leader>so", function() dap.step_over() end, { desc = "Debug: Step Over" })
			vim.keymap.set("n", "<leader>su", function() dap.step_out() end, { desc = "Debug: Step out" })
			vim.keymap.set("n", "<leader>si", function() dap.step_into() end, { desc = "Debug: Step Into" })
			vim.keymap.set("n", "<leader>sb", function() dap.step_back() end, { desc = "Debug: Step Back" })
            -- conditional breakpoints (i.e. if x = 100)
			vim.keymap.set("n", "<leader>B", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end)
		end,
	},
}
