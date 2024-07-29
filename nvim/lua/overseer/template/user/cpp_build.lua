return {
	name = "cpp_build",
	builder = function()
		-- Full path to current file (see :help expand())
		local file = vim.fn.expand("%:p")
		return {
			cmd = { "g++", "-std=c++17", "-g", file },
			postDebugTask = function()
				local dap = require("dap")
				dap.continue()
			end,
		}
	end,
	condition = {
		filetype = { "cpp" },
	},
}
