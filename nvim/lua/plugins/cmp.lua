return {
	{
		"saghen/blink.cmp",
		opts = {
			keymap = {
				preset = "enter",
				["<Tab>"] = {
					"select_next",
					"snippet_forward",
					"fallback",
				},
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			},
			completion = {
				menu = {
					border = "rounded",
				},
			},
		},
	},
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			opts.lsp.signature = {
				auto_open = { enabled = false },
			}
		end,
	},
	--[[{
		"zbirenbaum/copilot.lua",
		opts = {
			filetypes = {
				python = true, -- allow specific filetype
				cpp = true, -- allow specific filetype
				["*"] = false, -- disable for all other filetypes and ignore default `filetypes`
			},
			server = {
				type = "binary",
				--custom_server_filepath = "/home/user/copilot-lsp/language-server.js",
			},
		},
	},
    ]]
	--
}
