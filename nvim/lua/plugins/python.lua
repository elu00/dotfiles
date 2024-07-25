return {
	{
		"mfussenegger/nvim-dap-python",
		keys = {},
		config = function()
			if vim.fn.has("win32") == 1 then
				require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/Scripts/pythonw.exe"))
			else
				require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/bin/python"))
			end
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			opts.auto_brackets = opts.auto_brackets or {}
			table.insert(opts.auto_brackets, "python")
		end,
	},
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
				require("dap").configurations.python = {
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
		optional = true,
		opts = {
			handlers = {
				python = function() end,
			},
		},
	},
}
