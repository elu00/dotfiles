-- cmp-vimtex is initialized in cmp.lua
return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ignore_install = { "latex" }
			--[[if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "bibtex", "latex" })
			end
            --]]
			if type(opts.highlight.disable) == "table" then
				vim.list_extend(opts.highlight.disable, { "latex" })
			else
				opts.highlight.disable = { "latex" }
			end
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			max_lines = 2,
			on_attach = function(bufnr)
				return vim.bo[bufnr].filetype ~= "tex"
			end,
			separator = nil,
		},
	},
	{
		"lervag/vimtex",
		lazy = false,
		init = function()
			vim.g.vimtex_quickfix_open_on_warning = 0
			vim.g.vimtex_fold_enabled = true
			if vim.fn.has("macunix") ~= 0 then
				vim.g.vimtex_view_method = "skim"
			elseif vim.fn.has("wsl") ~= 0 then
				vim.g.vimtex_view_sioyek_exe = "sioyek.exe"
				vim.g.vimtex_view_method = "sioyek"
				vim.g.vimtex_callback_progpath = "wsl nvim"
			else
				vim.g.vimtex_view_general_viewer = "okular"
				vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
			end
			vim.g.matchup_override_vimtex = 1
			vim.g.tex_conceal = "abdgm"
			vim.g.vimtex_syntax_conceal = {
				accents = 1,
				fancy = 1,
				greek = 1,
				math_bounds = 0,
				math_delimiters = 1,
				math_fracs = 0,
				math_super_sub = 0,
				math_symbols = 1,
				styles = 0,
			}
			vim.g.vimtex_syntax_custom_cmds = {
				{ name = "R", mathmode = true, concealchar = "ℝ" },
				{ name = "Box", mathmode = true, concealchar = "󰄱" },
				--{ name = "Box", mathmode = true, concealchar = "☐" },
				--{ name = "Boxg", mathmode = true, concealchar = "☐" },
				{ name = "E", mathmode = true, concealchar = "E" },
				{ name = "P", mathmode = true, concealchar = "ℙ" },
				{ name = "ep", mathmode = true, concealchar = "ε" },
				{ name = "p", mathmode = true, concealchar = "∂" },
				{ name = "plj", mathmode = true, concealchar = "φ" },
				{ name = "ls", mathmode = true, concealchar = "≲" },
				{ name = "D", mathmode = true, concealchar = "ⅅ" },
				{ name = "div", mathmode = true },
				{ name = "setminus", mathmode = true, concealchar = [[\]] },
			}

			vim.g.vimtex_compiler_latexmk_engines = {
				_ = "-pdflatex",
				pdflatex = "-pdflatex",
				lualatex = "-lualatex",
				xelatex = "-xelatex",
			}
			vim.g.vimtex_syntax_custom_cmds_with_concealed_delims = {
				{ name = "ip", mathmode = 1, cchar_open = "⟨", cchar_close = "⟩" },
				{ name = "norm", mathmode = 1, cchar_open = "‖", cchar_close = "‖" },
				{ name = "abs", mathmode = 1, cchar_open = "|", cchar_close = "|" },
				{ name = "np", mathmode = 1, cchar_open = "(", cchar_close = ")" },
			}
			-- add which-key mapping descriptions for VimTex
			local wk = require("which-key")
			wk.add({
				{ "<localleader>l", buffer = 1, group = "VimTeX" },
				{ "<localleader>lC", buffer = 1, desc = "Full Clean" },
				{ "<localleader>lG", buffer = 1, desc = "Show Status for All" },
				{ "<localleader>lI", buffer = 1, desc = "Show Full Info" },
				{ "<localleader>lK", buffer = 1, desc = "Stop All VimTeX" },
				{ "<localleader>lL", buffer = 1, desc = "Compile Selection" },
				{ "<localleader>lT", buffer = 1, desc = "Toggle Table of Contents" },
				{ "<localleader>lX", buffer = 1, desc = "Reload VimTeX State" },
				{ "<localleader>la", buffer = 1, desc = "Show Context Menu" },
				{ "<localleader>lc", buffer = 1, desc = "Clean" },
				{ "<localleader>le", buffer = 1, desc = "Show Errors" },
				{ "<localleader>lg", buffer = 1, desc = "Show Status" },
				{ "<localleader>li", buffer = 1, desc = "Show Info" },
				{ "<localleader>lk", buffer = 1, desc = "Stop VimTeX" },
				{ "<localleader>ll", buffer = 1, desc = "Compile" },
				{ "<localleader>lm", buffer = 1, desc = "Show Imaps" },
				{ "<localleader>lo", buffer = 1, desc = "Show Compiler Output" },
				{ "<localleader>lq", buffer = 1, desc = "Show VimTeX Log" },
				{ "<localleader>ls", buffer = 1, desc = "Toggle Main" },
				{ "<localleader>lt", buffer = 1, desc = "Open Table of Contents" },
				{ "<localleader>lv", buffer = 1, desc = "View Compiled Document" },
				{ "<localleader>lx", buffer = 1, desc = "Reload VimTeX" },
				{ "[*", buffer = 1, desc = "Previous end of a LaTeX comment" },
				{ "[/", buffer = 1, desc = "Previous start of a LaTeX comment" },
				{ "[M", buffer = 1, desc = "Previous \\end" },
				{ "[N", buffer = 1, desc = "Previous end of a math zone" },
				{ "[R", buffer = 1, desc = "Previous \\end{frame}" },
				{ "[[", buffer = 1, desc = "Previous beginning of a section" },
				{ "[]", buffer = 1, desc = "Previous end of a section" },
				{ "[m", buffer = 1, desc = "Previous \\begin" },
				{ "[n", buffer = 1, desc = "Previous start of a math zone" },
				{ "[r", buffer = 1, desc = "Previous \\begin{frame}" },
				{ "]*", buffer = 1, desc = "Next end of a LaTeX comment %" },
				{ "]/", buffer = 1, desc = "Next start of a LaTeX comment %" },
				{ "]M", buffer = 1, desc = "Next \\end" },
				{ "]N", buffer = 1, desc = "Next end of a math zone" },
				{ "]R", buffer = 1, desc = "Next \\end{frame}" },
				{ "][", buffer = 1, desc = "Next beginning of a section" },
				{ "]]", buffer = 1, desc = "Next end of a section" },
				{ "]m", buffer = 1, desc = "Next \\begin" },
				{ "]n", buffer = 1, desc = "Next start of a math zone" },
				{ "]r", buffer = 1, desc = "Next \\begin{frame}" },
				{ "cs$", buffer = 1, desc = "Change surrounding math zone" },
				{ "csc", buffer = 1, desc = "Change surrounding command" },
				{ "csd", buffer = 1, desc = "Change surrounding delimiter" },
				{ "cse", buffer = 1, desc = "Change surrounding environment" },
				{ "ds$", buffer = 1, desc = "Delete surrounding math zone" },
				{ "dsc", buffer = 1, desc = "Delete surrounding command" },
				{ "dsd", buffer = 1, desc = "Delete surrounding delimiter" },
				{ "dse", buffer = 1, desc = "Delete surrounding environment" },
				{ "ts", buffer = 1, group = "VimTeX Toggles & Cycles" },
				{ "ts$", buffer = 1, desc = "Cycle inline, display & numbered equation" },
				{ "tsD", buffer = 1, desc = "Reverse Cycle (), \\left(\\right) [, ...]" },
				{ "tsc", buffer = 1, desc = "Toggle star of command" },
				{ "tsd", buffer = 1, desc = "Cycle (), \\left(\\right) [,...]" },
				{ "tse", buffer = 1, desc = "Toggle star of environment" },
				{ "tsf", buffer = 1, desc = "Toggle a/b vs \\frac{a}{b}" },
			})
			wk.add({
				{
					mode = { "o" },
					{ "a$", buffer = 1, desc = "LaTeX Math Zone" },
					{ "aP", buffer = 1, desc = "LaTeX Section, Paragraph, ..." },
					{ "ac", buffer = 1, desc = "LaTeX Command" },
					{ "ad", buffer = 1, desc = "LaTeX Math Delimiter" },
					{ "ae", buffer = 1, desc = "LaTeX Environment" },
					{ "am", buffer = 1, desc = "LaTeX Item" },
					{ "i$", buffer = 1, desc = "LaTeX Math Zone" },
					{ "iP", buffer = 1, desc = "LaTeX Section, Paragraph, ..." },
					{ "ic", buffer = 1, desc = "LaTeX Command" },
					{ "id", buffer = 1, desc = "LaTeX Math Delimiter" },
					{ "ie", buffer = 1, desc = "LaTeX Environment" },
					{ "im", buffer = 1, desc = "LaTeX Item" },
				},
			})
		end,
	},
}
