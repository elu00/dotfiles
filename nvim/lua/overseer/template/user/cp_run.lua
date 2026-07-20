return {
	name = "cp_run",
	builder = function()
		local file = vim.fn.expand("%:p")
		local cmd

		if vim.bo.filetype == "python" then
			cmd = string.format('python3 "%s" < meme.txt', file)
		else
			cmd = string.format('g++ -std=c++17 -g "%s" && ./a.out < meme.txt', file)
		end

		return {
			cmd = cmd,
			-- Use standard components to open the split instead of toggleterm strategy
			components = {
				"default",
				{ "open_output", direction = "horizontal", on_start = "always" },
			},
		}
	end,
	condition = {
		filetype = { "cpp", "python" },
	},
}
