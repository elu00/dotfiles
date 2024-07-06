return {
	"stevearc/overseer.nvim",
	lazy = false,
	opts = {},
	keys = {
		{ "<leader>o", "<cmd>OverseerToggle <cr>", desc = "Toggle overseer" },
		{ "<leader>p", "<cmd>OverseerRun cp_run <cr>", desc = "Run cp files with overseer" },
		{ "<leader>i", "<cmd>vsplit meme.txt <cr>", desc = "Open cp input file" },
	},
	config = function()
		require("overseer").setup({
			strategy = "toggleterm",
			task_list = {
				direction = "right",
			},
			templates = { "builtin", "user.cp_run" },
		})
	end,
}
