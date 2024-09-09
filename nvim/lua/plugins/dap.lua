return {
	{
		"mfussenegger/nvim-dap",
		opts = function()
			local dap = require("dap")
			dap.configurations.cpp = {
				{
					name = "Run debug",
					type = "codelldb",
					preLaunchTask = "cpp_build",
					request = "launch",
					program = "a.out",
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					stdio = { "meme.txt", nil, nil },
				},
			}
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		enabled = false,
	},
}
