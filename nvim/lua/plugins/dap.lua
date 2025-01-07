return {
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		dependencies = {
			"mfussenegger/nvim-dap-python",
			lazy = true,
			config = function()
				require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "venv/bin/python"))
				local dap = require("dap")
				dap.configurations.python = {
					{
						type = "python",
						request = "launch",
						name = "debug",
						program = "${file}",
						console = "integratedTerminal",
						args = { "redirstdin" },
						-- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
					},
				}
			end,
		},
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		opts = {
			handlers = {
				python = function() end,
				codelldb = function(config)
					config.configurations = {
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
					require("mason-nvim-dap").default_setup(config)
					require("dap").configurations.cpp = config.configurations
				end,
			},
		},
	},
}
