return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"mfussenegger/nvim-dap-python",
			config = function()
				if vim.fn.has("win32") == 1 then
					require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/Scripts/pythonw.exe"))
				else
					require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/bin/python"))
				end
				local dap = require("dap")
				dap.configurations.python = {
					{
						type = "python",
						request = "launch",
						name = "debug",
						program = "${file}",
						console = "integratedTerminal",
						args = { "womais" },
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
	{
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			opts.auto_brackets = opts.auto_brackets or {}
			table.insert(opts.auto_brackets, "python")
		end,
	},
	--[[
	{
		"theHamsta/nvim-dap-virtual-text",
		enabled = false,
	},
    --]]
}
