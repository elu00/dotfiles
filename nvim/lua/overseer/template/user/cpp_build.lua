return {
	name = "cpp_build",
	builder = function()
		-- Full path to current file (see :help expand())
		local file = vim.fn.expand("%:p")
		return {
			cmd = { "g++", "-std=c++17", "-g", file },
		}
	end,
	condition = {
		filetype = { "cpp" },
	},
}
