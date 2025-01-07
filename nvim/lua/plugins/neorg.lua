return {
	{
		"echasnovski/mini.icons",
		opts = {
			filetype = {
				["norg"] = { glyph = "󰊢" },
			},
		},
	},
	{
		"nvim-neorg/neorg",
		-- tag = "*",
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
