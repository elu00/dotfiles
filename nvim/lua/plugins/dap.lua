return {
	"mfussenegger/nvim-dap",
	opts = function()
		-- Need to compile with `g++ main.cpp -g`. Then `"a.out"` is available with debug symbols
		local dap = require("dap")
		dap.configurations.cpp = {
			{
				name = "Run debug",
				type = "codelldb",
				request = "launch",
				program = "a.out",
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				stdio = { "meme.txt", nil, nil },
			},
		}
	end,
}
