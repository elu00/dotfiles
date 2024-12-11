return {
	name = "cp_run",
	builder = function()
		-- Full path to current file (see :help expand())
		local file = vim.fn.expand("%:p")
		if vim.bo.filetype == "python" then
			return {
				cmd = { "python3", file, "<", "meme.txt" },
			}
		else
			return {
				cmd = { "g++", "-std=c++17", "-g", file, "&&", "./a.out", "<", "meme.txt" },
			}
		end
	end,
	condition = {
		filetype = { "cpp", "python" },
	},
}
