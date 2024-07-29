return {
	"stevearc/overseer.nvim",
	lazy = false,
	opts = {
		dap = true,
	},
	keys = {
		{ "<leader>o", "<cmd>OverseerToggle <cr>", desc = "Toggle overseer" },
		{ "<leader>p", "<cmd>OverseerRun cp_run <cr>", desc = "Run cp files with overseer" },
		{
			"<leader>P",
			"<cmd>OverseerRun cpp_build <cr>",
			desc = "Run cp files with overseer",
		},
		{ "<leader>i", "<cmd>vsplit meme.txt <cr>", desc = "Open cp input file" },
	},
	config = function()
		require("overseer").setup({
			strategy = "toggleterm",
			task_list = {
				direction = "right",
			},
			templates = { "builtin", "user.cp_run", "user.cpp_build" },
		})
	end,
}
