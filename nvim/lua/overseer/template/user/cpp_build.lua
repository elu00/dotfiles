return {
	name = "cpp_build",
	builder = function()
		local file = vim.fn.expand("%:p")
		return {
			cmd = { "g++", "-std=c++17", "-g", file },
			components = {
				"default",
				-- You can change "horizontal" to "vertical" or "float" based on preference
				{ "open_output", direction = "horizontal", on_start = "always" },
			},
		}
	end,
	condition = {
		filetype = { "cpp" },
	},
}
