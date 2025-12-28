return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		spec = {
			{ "<leader>a", group = "ai" },
			{ "<leader>d", group = "debug" },
			{ "<leader>dt", desc = "Toggle Breakpoint" },
			{ "<leader>dc", desc = "Continue" },
			{ "<leader>dr", desc = "Restart" },
			{ "<leader>dq", desc = "Quit/Terminate" },
			{ "<leader>w", desc = "Save/Write Buffer" },
			{ "gd", desc = "Go to defintion" },
			{ "gD", desc = "Go to declaration" },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
