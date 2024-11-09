return {
	{
		"saghen/blink.cmp",
		dependencies = {
			-- add blink.compat to dependencies
			{ "saghen/blink.compat", version = "event", opts = {
				enable_events = true,
			} },
			{
				"Exafunction/codeium.nvim",
				cmd = "Codeium",
				build = ":Codeium Auth",
				opts = {},
			},
		},
		opts = {
			keymap = {
				preset = "enter",
				["<Tab>"] = {
					function(cmp)
						if cmp.is_in_snippet() then
							return cmp.accept()
						else
							return cmp.select_next()
						end
					end,
					"snippet_forward",
					"fallback",
				},
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			},
			sources = {
				completion = {
					enabled_providers = { "lsp", "path", "snippets", "buffer", "codeium" },
				},
				providers = {
					codeium = {
						name = "codeium", -- IMPORTANT: use the same name as you would for nvim-cmp
						module = "blink.compat.source",

						-- all blink.cmp source config options work as normal:
						score_offset = 3,
						max_items = 4,

						opts = {
							-- options passed to the completion source
							-- equivalent to `option` field of nvim-cmp source config
						},
					},
				},
			},
			windows = {
				autocomplete = {
					border = "rounded",
					draw = function(ctx)
						local MiniIcons = require("mini.icons")
						local source = ctx.item.source_name
						local icon = source == "codeium" and MiniIcons.get("lsp", "event") or ctx.kind_icon
						return {
							" ",
							{ icon, ctx.icon_gap, hl_group = "BlinkCmpKind" .. ctx.kind },
							{
								ctx.label,
								ctx.kind == "Snippet" and "~" or "",
								(ctx.item.labelDetails and ctx.item.labelDetails.detail)
										and ctx.item.labelDetails.detail
									or "",
								fill = true,
								hl_group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel",
								max_width = 80,
							},
							" ",
						}
					end,
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
}
