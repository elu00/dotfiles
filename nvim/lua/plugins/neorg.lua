return {
	{
		"vhyrro/luarocks.nvim",
		priority = 1000, -- We'd like this plugin to load first out of the rest
		config = true, -- This automatically runs `require("luarocks-nvim").setup()`
	},
	{
		"nvim-neorg/neorg",
		-- tag = "*",
		dependencies = { "luarocks.nvim" },
		--version = "v7.0.0",
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {
						config = {
							disable = {
								"core.todo-introspector",
							},
						},
					}, -- Loads default behaviour
					["core.concealer"] = {
						config = {
							icons = {
								todo = {
									pending = {
										icon = "",
									},
								},
							},
						},
					}, -- Adds pretty icons to your documents
					["core.highlights"] = {
						config = {
							highlights = {
								todo_items = {
									pending = "+Special",
								},
							},
						},
					}, -- Adds pretty icons to your documents
					["core.dirman"] = { -- Manages Neorg workspaces
						config = {
							workspaces = {
								notes = "~/math/notes",
							},
						},
					},
				},
			})
		end,
	},
}
