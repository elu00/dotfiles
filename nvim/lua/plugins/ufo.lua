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
	{
		"chrisgrieser/nvim-origami",
		event = "BufReadPost", -- later will not save folds
		opts = true,
	},

	{ -- better statuscolumn
		"luukvbaal/statuscol.nvim",
		event = { "BufRead", "BufNewFile" },
		opts = function()
			local builtin = require("statuscol.builtin")
			return {
				ft_ignore = { "neo-tree", "neo-tree-popup", "alpha", "lazy", "mason" },
				segments = {
					{
						sign = { name = { "Diagnostic*" }, text = { ".*" }, maxwidth = 1, colwidth = 1, auto = true },
						click = "v:lua.ScSa",
					},
					{ text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
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
				provider_selector = function()
					return { "treesitter", "indent" }
				end,
				open_fold_hl_timeout = 400,
				close_fold_kinds = { "imports", "comment" },
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
--[[
--------------------------------------------------------------------------------

return {
       { -- UFO
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        event = "BufReadPost", -- needed for folds to load in time
        keys = {
            {
                "zr",
                function()
                    require("ufo").openFoldsExceptKinds({ "comment" })
                end,
                desc = " 󱃄 Open All Folds except comments",
            },
            {
                "zm",
                function()
                    require("ufo").closeAllFolds()
                end,
                desc = " 󱃄 Close All Folds",
            },
            {
                "z1",
                function()
                    require("ufo").closeFoldsWith(1)
                end,
                desc = " 󱃄 Close L1 Folds",
            },
            {
                "z2",
                function()
                    require("ufo").closeFoldsWith(2)
                end,
                desc = " 󱃄 Close L2 Folds",
            },
            {
                "z3",
                function()
                    require("ufo").closeFoldsWith(3)
                end,
                desc = " 󱃄 Close L3 Folds",
            },
            {
                "z4",
                function()
                    require("ufo").closeFoldsWith(4)
                end,
                desc = " 󱃄 Close L4 Folds",
            },
        },
        init = function()
            -- INFO fold commands usually change the foldlevel, which fixes folds, e.g.
            -- auto-closing them after leaving insert mode, however ufo does not seem to
            -- have equivalents for zr and zm because there is no saved fold level.
            -- Consequently, the vim-internal fold levels need to be disabled by setting
            -- them to 99
            vim.opt.foldlevel = 99
            vim.opt.foldlevelstart = 99
        end,
        opts = {
            provider_selector = function(_, ft, _)
                -- INFO some filetypes only allow indent, some only LSP, some only
                -- treesitter. However, ufo only accepts two kinds as priority,
                -- therefore making this function necessary :/
                local lspWithOutFolding = { "markdown", "sh", "css", "html", "python" }
                if vim.tbl_contains(lspWithOutFolding, ft) then
                    return { "treesitter", "indent" }
                end
                return { "lsp", "indent" }
            end,
            -- open opening the buffer, close these fold kinds
            -- use `:UfoInspect` to get available fold kinds from the LSP
            close_fold_kinds = { "imports", "comment" },
            open_fold_hl_timeout = 800,
            fold_virt_text_handler = foldTextFormatter,
        },
    },
}
--]]
