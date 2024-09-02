local foldIcon = ""
local hlgroup = "NonText"
local function foldTextFormatter(virtText, lnum, endLnum, width, truncate)
	local newVirtText = {}
	local suffix = "  " .. foldIcon .. "  " .. tostring(endLnum - lnum)
	local sufWidth = vim.fn.strdisplaywidth(suffix)
	local targetWidth = width - sufWidth
	local curWidth = 0
	for _, chunk in ipairs(virtText) do
		local chunkText = chunk[1]
		local chunkWidth = vim.fn.strdisplaywidth(chunkText)
		if targetWidth > curWidth + chunkWidth then
			table.insert(newVirtText, chunk)
		else
			chunkText = truncate(chunkText, targetWidth - curWidth)
			local hlGroup = chunk[2]
			table.insert(newVirtText, { chunkText, hlGroup })
			chunkWidth = vim.fn.strdisplaywidth(chunkText)
			if curWidth + chunkWidth < targetWidth then
				suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
			end
			break
		end
		curWidth = curWidth + chunkWidth
	end
	table.insert(newVirtText, { suffix, hlgroup })
	return newVirtText
end

return {
	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = {
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "",
					-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
					-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
					-- prefix = "icons",
				},
				severity_sort = true,
			},
		},
		init = function()
			local keys = require("lazyvim.plugins.lsp.keymaps").get()
			keys[#keys + 1] = { "K", false }
		end,
	},
	--[[{
		"chrisgrieser/nvim-origami",
		event = "BufReadPost", -- later will not save folds
		opts = true,
	},]]
	--

	{ -- better statuscolumn
		"luukvbaal/statuscol.nvim",
		event = { "BufRead", "BufNewFile" },
		opts = function()
			local builtin = require("statuscol.builtin")
			return {
				ft_ignore = { "neo-tree", "neo-tree-popup", "alpha", "lazy", "mason" },
				segments = {
					{ text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
					{
						sign = {
							name = { "Diagnostic*", "Dap*" },
							text = { "%s" },
							maxwidth = 1,
							colwidth = 1,
							auto = true,
						},
						click = "v:lua.ScSa",
					},
					{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
				},
			}
		end,
		init = function() end,
		config = function(_, opts)
			require("statuscol").setup(opts)
		end,
	},
	{ -- better fold
		"kevinhwang91/nvim-ufo",
		event = { "BufRead", "BufNewFile" },
		dependencies = { "kevinhwang91/promise-async" },
		init = function()
			vim.o.fillchars = [[eob: ,fold: ,foldopen:󰅀,foldsep: ,foldclose:󰅂]]
			vim.o.foldcolumn = "1"
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
		end,
		opts = function()
			local handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = (" ... 󰁂 %d "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end

			return {
				fold_virt_text_handler = handler,
				provider_selector = function(bufnr, filetype, buftype)
					if filetype == "tex" then
						return ""
					else
						return { "treesitter", "indent" }
					end
				end,
				open_fold_hl_timeout = 400,
				--close_fold_kinds_for_ft = { "imports", "comment" },
				preview = {
					win_config = { border = { "", "─", "", "", "", "─", "", "" }, winblend = 0 },
					mappings = {
						scrollU = "<C-b>",
						scrollD = "<C-f>",
						jumpTop = "[",
						jumpBot = "]",
					},
				},
			}
		end,
		config = function(_, opts)
			require("ufo").setup(opts)

			local map = require("lazyvim.util").safe_keymap_set
			map("n", "K", function()
				if not require("ufo").peekFoldedLinesUnderCursor() then
					vim.lsp.buf.hover()
				end
			end, { desc = "Peek folded lines under cursor or hover" })
		end,
	},
}
