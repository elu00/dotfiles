return {
	{
		"stevearc/overseer.nvim",
		opts = {
			dap = true,
		},
		keys = {
			{ "<leader>o", "<cmd>OverseerToggle <cr>", desc = "Toggle overseer" },
			{ "<leader>p", "<cmd>OverseerRun cp_run <cr>", desc = "Run cp files with overseer" },
			{ "<leader>i", "<cmd>vsplit meme.txt <cr>", desc = "Open cp input file" },
		},
		config = function()
			require("overseer").setup({
				strategy = { "toggleterm" },
				task_list = {
					direction = "right",
				},
				templates = { "builtin", "user.cp_run", "user.cpp_build" },
			})
		end,
	},

	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<c-\>]],
				shade_terminals = false,
				-- add --login so ~/.zprofile is loaded
				-- https://vi.stackexchange.com/questions/16019/neovim-terminal-not-reading-bash-profile/16021#16021
				shell = "zsh --login",
			})
		end,
		keys = {
			{ [[<C-\>]] },
			{ "<leader>0", "<Cmd>2ToggleTerm<Cr>", desc = "Terminal #2" },
		},
	},
}
