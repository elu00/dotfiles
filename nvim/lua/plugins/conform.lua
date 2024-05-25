return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				--tex = { "latexindent" },
				javascript = { "deno_fmt" },
			},
			--[[formatters = {
				deno_fmt = {
					prepend_args = { "--indent-width", "4" },
					--indent-width
				},
			},]]
		},
	},
}
