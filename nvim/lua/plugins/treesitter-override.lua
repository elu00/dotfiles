return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			--[[
			ignore_install = { "latex" },
			highlight = {
				enable = true,
				disable = { "latex" },
			},
            --]]
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
