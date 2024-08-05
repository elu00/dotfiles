return {
	{
		"nvim-treesitter/nvim-treesitter",
		keys = {
			{ "<c-space>", false },
			{ "<bs>", false },
		},
		opts = {
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-n>",
					node_incremental = "<C-n>",
					scope_incremental = "<C-s>",
					node_decremental = "<C-r>",
				},
			},
			ensure_installed = {
				"bash",
				"cpp",
				"html",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"vim",
				"vimdoc",
				"yaml",
			},
		},
	},
}
