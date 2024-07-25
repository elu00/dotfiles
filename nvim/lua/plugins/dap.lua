return {
	"mfussenegger/nvim-dap",
	opts = function()
		--[[
		local dap = require("dap")
		table.insert(dap.configurations.python, {
			type = "python",
			request = "launch",
			name = "My custom launch configuration",
			program = "${file} < meme.txt",
			-- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
		})
        --]]
		--[[
		-- Need to compile with `g++ main.cpp -g`. Then `"a.out"` is available with debug symbols
		dap.configurations.cpp = {
			{
				args = {},
				cwd = "${workspaceFolder}",
				name = "Womais",
				program = "./a.out",
				request = "launch",
				runInTerminal = true,
				stopOnEntry = false,
				type = "codelldb",
			},
		}
        ]]
		--
	end,
}
