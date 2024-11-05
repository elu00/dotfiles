return {
	{
		"hrsh7th/nvim-cmp",
		enabled = false,
	},
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
		event = "BufReadPre",
		version = "v0.*", -- REQUIRED release tag to download pre-built binaries
		-- https://github.com/chrisgrieser/.config/blob/main/nvim/lua/plugins/blink-cmp.lua

		---@module "blink.cmp"
		---@type blink.cmp.Config
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
			trigger = {
				completion = {
					keyword_range = "full", -- full|prefix
				},
			},
			--[[highlight = {
				use_nvim_cmp_as_default = true,
			},]]
			--
			nerd_font_variant = "normal",
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
