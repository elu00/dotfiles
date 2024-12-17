-- https://github.com/lkhphuc/dotfiles/blob/e49b9af0f67dee78c177f8f9dbbe291d76007479/nvim/lua/plugins/ui.lua?plain=1#L78
return {
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			opts.sections.lualine_b = {} -- remove git branch info
			-- opts.sections.lualine_c[1] = require("lazyvim.util").lualine.root_dir({ cwd = true })
			--opts.sections.lualine_c[2] = "" -- no diagnostic in statusline
			---- Remove some LazyVim's default
			--[[for _, component in ipairs(opts.sections.lualine_x) do
				if component[1] == "diff" then
					component[1] = ""
				end
			end]]
			--
			opts.sections.lualine_x =
				{
					{ -- noice current keystrokes
						function()
							return require("noice").api.status.command.get()
						end,
						cond = function()
							return package.loaded["noice"] and require("noice").api.status.command.has()
						end,
						color = function()
							return { fg = Snacks.util.color("Statement") }
						end,
					},
					{
						function()
							return require("noice").api.status.mode.get()
						end,
						cond = function()
							return package.loaded["noice"] and require("noice").api.status.mode.has()
						end,
						color = function()
							return { fg = Snacks.util.color("Constant") }
						end,
					},
					{
						function()
							return "  " .. require("dap").status()
						end,
						cond = function()
							return package.loaded["dap"] and require("dap").status() ~= ""
						end,
						color = function()
							return { fg = Snacks.util.color("Debug") }
						end,
					},
				}, vim.list_extend(opts.sections.lualine_y, {
					{ --terminal
						function()
							return " " .. vim.o.channel
						end,
						cond = function()
							return vim.o.buftype == "terminal"
						end,
						color = function()
							return { fg = Snacks.util.color("Constant") }
						end,
					},
				})
		end,
	},
}
