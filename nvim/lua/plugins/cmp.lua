return {
	{
		"L3MON4D3/LuaSnip",
		keys = function()
			return {}
		end,
		init = function()
			local ls = require("luasnip")
			local s = ls.snippet
			local f = ls.function_node
			ls.config.setup({ enable_autosnippets = true })
			local scriptMapping = {
				["0"] = { "⁰", "₀" },
				["1"] = { "¹", "₁" },
				["2"] = { "²", "₂" },
				["3"] = { "³", "₃" },
				["4"] = { "⁴", "₄" },
				["5"] = { "⁵", "₅" },
				["6"] = { "⁶", "₆" },
				["7"] = { "⁷", "₇" },
				["8"] = { "⁸", "₈" },
				["9"] = { "⁹", "₉" },
				["a"] = { "ᵃ", "ₐ" },
				["b"] = { "ᵇ", "ᵦ" },
				["c"] = { "ᶜ", "c" }, -- No standard Unicode subscript for "c"
				["d"] = { "ᵈ", "d" }, -- No standard Unicode subscript for "d"
				["e"] = { "ᵉ", "ₑ" },
				["f"] = { "ᶠ", "f" }, -- No standard Unicode subscript for "f"
				["g"] = { "ᵍ", "g" }, -- No standard Unicode subscript for "g"
				["h"] = { "ʰ", "ₕ" },
				["i"] = { "ⁱ", "ᵢ" },
				["j"] = { "ʲ", "ⱼ" },
				["k"] = { "ᵏ", "ₖ" },
				["l"] = { "ˡ", "ₗ" },
				["m"] = { "ᵐ", "ₘ" },
				["n"] = { "ⁿ", "ₙ" },
				["o"] = { "ᵒ", "ₒ" },
				["p"] = { "ᵖ", "ₚ" },
				["q"] = { "q", "q" }, -- No standard Unicode subscript for "q"
				["r"] = { "ʳ", "ᵣ" },
				["s"] = { "ˢ", "ₛ" },
				["t"] = { "ᵗ", "ₜ" },
				["u"] = { "ᵘ", "ᵤ" },
				["v"] = { "ᵛ", "ᵥ" },
				["w"] = { "ʷ", "w" }, -- No standard Unicode subscript for "w"
				["x"] = { "ˣ", "ₓ" },
				["y"] = { "ʸ", "y" }, -- No standard Unicode subscript for "y"
				["z"] = { "ᶻ", "z" }, -- No standard Unicode subscript for "z"
				["A"] = { "ᴬ", "A" }, -- No standard Unicode subscript for "A"
				["B"] = { "ᴮ", "B" }, -- No standard Unicode subscript for "B"
				["C"] = { "ᶜ", "C" }, -- No standard Unicode subscript for "C"
				["D"] = { "ᴰ", "D" }, -- No standard Unicode subscript for "D"
				["E"] = { "ᴱ", "E" }, -- No standard Unicode subscript for "E"
				["F"] = { "ᶠ", "F" }, -- No standard Unicode subscript for "F"
				["G"] = { "ᴳ", "G" }, -- No standard Unicode subscript for "G"
				["H"] = { "ᴴ", "H" }, -- No standard Unicode subscript for "H"
				["I"] = { "ᴵ", "I" }, -- No standard Unicode subscript for "I"
				["J"] = { "ᴶ", "J" }, -- No standard Unicode subscript for "J"
				["K"] = { "ᴷ", "K" }, -- No standard Unicode subscript for "K"
				["L"] = { "ᴸ", "L" }, -- No standard Unicode subscript for "L"
				["M"] = { "ᴹ", "M" }, -- No standard Unicode subscript for "M"
				["N"] = { "ᴺ", "N" }, -- No standard Unicode subscript for "N"
				["O"] = { "ᴼ", "O" }, -- No standard Unicode subscript for "O"
				["P"] = { "ᴾ", "P" }, -- No standard Unicode subscript for "P"
				["Q"] = { "Q", "Q" }, -- No standard Unicode subscript for "Q"
				["R"] = { "ᴿ", "R" }, -- No standard Unicode subscript for "R"
				["S"] = { "ˢ", "S" }, -- No standard Unicode subscript for "S"
				["T"] = { "ᵀ", "T" }, -- No standard Unicode subscript for "T"
				["U"] = { "ᵁ", "U" }, -- No standard Unicode subscript for "U"
				["V"] = { "ⱽ", "V" }, -- No standard Unicode subscript for "V"
				["W"] = { "ᵂ", "W" }, -- No standard Unicode subscript for "W"
				["X"] = { "ˣ", "X" }, -- No standard Unicode subscript for "X"
				["Y"] = { "ʸ", "Y" }, -- No standard Unicode subscript for "Y"
				["Z"] = { "ᶻ", "Z" }, -- No standard Unicode subscript for "Z"
			}

			-- Function to get script equivalent
			local function getSupEquivalent(char)
				local script = scriptMapping[char]
				if script then
					return script[1]
				else
					return char
				end
			end
			local function getSubEquivalent(char)
				local script = scriptMapping[char]
				if script then
					return script[2]
				else
					return char
				end
			end

			-- luasnip snippet definitions
			local superscriptSnippet = s(
				{
					name = "superscriptSnippet",
					snippetType = "autosnippet",
					trig = "(%S)%^{(%w+)}",
					trigEngine = "pattern",
					desc = "Converts the following character to its subscript equivalent",
					hidden = true,
				},
				f(function(_, snip)
					return snip.captures[1] .. string.gsub(snip.captures[2], ".", getSupEquivalent)
				end, {})
			)

			local subscriptSnippet = s(
				{
					name = "subscriptSnippet",
					snippetType = "autosnippet",
					trig = "(%S)%_{(%w+)}",
					trigEngine = "pattern",
					desc = "Converts the following character to its subscript equivalent",
					hidden = true,
				},
				f(function(_, snip)
					return snip.captures[1] .. string.gsub(snip.captures[2], ".", getSubEquivalent)
				end, {})
			)
			ls.add_snippets("cpp", { superscriptSnippet, subscriptSnippet })
		end,
	},
	{
		"hrsh7th/nvim-cmp",

		dependencies = {
			--"micangl/cmp-vimtex",
			"amarakon/nvim-cmp-lua-latex-symbols",
		},
		opts = function(_, opts)
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local luasnip = require("luasnip")
			local cmp = require("cmp")

			opts.sources = cmp.config.sources(
				vim.list_extend(opts.sources, { { name = "vimtex" }, { name = "lua-latex-symbols" } })
			)
			opts.completion = {
				completeopt = "menu,menuone,noinsert,noselect,preview",
			}

			opts.mapping = vim.tbl_extend("force", opts.mapping, {
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						-- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
						cmp.select_next_item()
					-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
					-- this way you will only jump inside the snippet region
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			})
		end,
	},
}
