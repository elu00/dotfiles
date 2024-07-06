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
			if vim.fn.has("wsl") ~= 0 then
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
				{ name = "np", mathmode = 1, cchar_open = "(", cchar_close = ")" },
			}
			-- add which-key mapping descriptions for VimTex
			vim.api.nvim_create_autocmd("FileType", {
				desc = "Set up VimTex Which-Key descriptions",
				group = vim.api.nvim_create_augroup("vimtex_mapping_descriptions", { clear = true }),
				pattern = "tex",
				callback = function(event)
					local wk = require("which-key")
					local opts = {
						mode = "n", -- NORMAL mode
						buffer = event.buf, -- Specify a buffer number for buffer local mappings to show only in tex buffers
					}
					local mappings = {
						["<localleader>l"] = {
							name = "+VimTeX",
							a = "Show Context Menu",
							C = "Full Clean",
							c = "Clean",
							e = "Show Errors",
							G = "Show Status for All",
							g = "Show Status",
							i = "Show Info",
							I = "Show Full Info",
							k = "Stop VimTeX",
							K = "Stop All VimTeX",
							L = "Compile Selection",
							l = "Compile",
							m = "Show Imaps",
							o = "Show Compiler Output",
							q = "Show VimTeX Log",
							s = "Toggle Main",
							t = "Open Table of Contents",
							T = "Toggle Table of Contents",
							v = "View Compiled Document",
							X = "Reload VimTeX State",
							x = "Reload VimTeX",
						},
						["ts"] = {
							name = "VimTeX Toggles & Cycles", -- optional group name
							["$"] = "Cycle inline, display & numbered equation",
							c = "Toggle star of command",
							d = "Cycle (), \\left(\\right) [,...]",
							D = "Reverse Cycle (), \\left(\\right) [, ...]",
							e = "Toggle star of environment",
							f = "Toggle a/b vs \\frac{a}{b}",
						},
						["[/"] = "Previous start of a LaTeX comment",
						["[*"] = "Previous end of a LaTeX comment",
						["[["] = "Previous beginning of a section",
						["[]"] = "Previous end of a section",
						["[m"] = "Previous \\begin",
						["[M"] = "Previous \\end",
						["[n"] = "Previous start of a math zone",
						["[N"] = "Previous end of a math zone",
						["[r"] = "Previous \\begin{frame}",
						["[R"] = "Previous \\end{frame}",
						["]/"] = "Next start of a LaTeX comment %",
						["]*"] = "Next end of a LaTeX comment %",
						["]["] = "Next beginning of a section",
						["]]"] = "Next end of a section",
						["]m"] = "Next \\begin",
						["]M"] = "Next \\end",
						["]n"] = "Next start of a math zone",
						["]N"] = "Next end of a math zone",
						["]r"] = "Next \\begin{frame}",
						["]R"] = "Next \\end{frame}",
						["cs"] = {
							c = "Change surrounding command",
							e = "Change surrounding environment",
							["$"] = "Change surrounding math zone",
							d = "Change surrounding delimiter",
						},
						["ds"] = {
							c = "Delete surrounding command",
							e = "Delete surrounding environment",
							["$"] = "Delete surrounding math zone",
							d = "Delete surrounding delimiter",
						},
					}
					wk.register(mappings, opts)
					-- VimTeX Text Objects without variants with targets.vim
					opts = {
						mode = "o", -- Operator pending mode
						buffer = event.buf,
					}
					local objects = {
						["ic"] = [[LaTeX Command]],
						["ac"] = [[LaTeX Command]],
						["id"] = [[LaTeX Math Delimiter]],
						["ad"] = [[LaTeX Math Delimiter]],
						["ie"] = [[LaTeX Environment]],
						["ae"] = [[LaTeX Environment]],
						["i$"] = [[LaTeX Math Zone]],
						["a$"] = [[LaTeX Math Zone]],
						["iP"] = [[LaTeX Section, Paragraph, ...]],
						["aP"] = [[LaTeX Section, Paragraph, ...]],
						["im"] = [[LaTeX Item]],
						["am"] = [[LaTeX Item]],
					}
					wk.register(objects, opts)
				end,
			})
		end,
	},
}
