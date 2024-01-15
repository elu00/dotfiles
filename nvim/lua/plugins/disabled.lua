return {
	--{ "hrsh7th/nvim-cmp", enabled = false },
	-- pair things
	{ "echasnovski/mini.pairs", enabled = false },
	-- Inline error messages/warnings
	--{ "folke/trouble.nvim", enabled = false },
	-- Faster search navigation?
	{ "folke/flash.nvim", enabled = false },
	-- highlight copies of the current word
	{ "RRethy/vim-illuminate", enabled = false },
	-- inline git status
	{ "lewis6991/gitsigns.nvim", enabled = false },
	-- linter
	--{ "mfussenegger/nvim-lint", enabled = false },
	{
		"nvim-treesitter/nvim-treesitter-context",
		--[[enabled = function()
			if vim.bo.filetype == "tex" then
				-- disable for .tex files
				return false
			end
			return true
		end,]]
		--
		enabled = false,
	},
}
