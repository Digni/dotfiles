return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")

			-- Leader keybindings
			vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
			vim.keymap.set("n", "<leader>dc", dap.continue, {})
			vim.keymap.set("n", "<leader>dr", dap.restart, {})
			vim.keymap.set("n", "<leader>dq", dap.terminate, {})

			-- Standard debugger keybindings (F-keys)
			vim.keymap.set("n", "<F5>", dap.continue, {})
			vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, {})
			vim.keymap.set("n", "<F10>", dap.step_over, {})
			vim.keymap.set("n", "<F11>", dap.step_into, {})
			vim.keymap.set("n", "<F12>", dap.step_out, {})

			-- Rust debugging with CodeLLDB
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = vim.fn.expand("~/.local/share/nvim/mason/bin/codelldb"),
					args = { "--port", "${port}" },
				},
			}

			dap.configurations.rust = {
				{
					name = "Launch",
					type = "codelldb",
					request = "launch",
					program = function()
						local cwd = vim.fn.getcwd()
						-- Try to read package name from Cargo.toml
						local cargo_toml = cwd .. "/Cargo.toml"
						if vim.fn.filereadable(cargo_toml) == 1 then
							for line in io.lines(cargo_toml) do
								local package_name = line:match('^name%s*=%s*"([^"]+)"')
								if package_name then
									return cwd .. "/target/debug/" .. package_name
								end
							end
						end
						-- Fallback to prompting
						return vim.fn.input("Path to executable: ", cwd .. "/target/debug/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
				},
				{
					name = "Launch (manual)",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
				},
			}

			-- Go debugging with Delve
			dap.adapters.delve = {
				type = "server",
				port = "${port}",
				executable = {
					command = vim.fn.expand("~/.local/share/nvim/mason/bin/dlv"),
					args = { "dap", "-l", "127.0.0.1:${port}" },
				},
			}

			dap.configurations.go = {
				{
					type = "delve",
					name = "Debug",
					request = "launch",
					program = "${file}",
				},
				{
					type = "delve",
					name = "Debug (main package)",
					request = "launch",
					program = "${workspaceFolder}",
				},
				{
					type = "delve",
					name = "Debug test",
					request = "launch",
					mode = "test",
					program = "${file}",
				},
				{
					type = "delve",
					name = "Debug test (go.mod)",
					request = "launch",
					mode = "test",
					program = "./${relativeFileDirname}",
				},
			}
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup()
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
		end,
	},
	{
		"Cliffback/netcoredbg-macOS-arm64.nvim",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("netcoredbg-macOS-arm64").setup(require("dap"))
		end,
	},
}
