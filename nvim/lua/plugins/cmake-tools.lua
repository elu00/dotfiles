-- disable this for now until compiler.nvim updates some things
--[[
vim.g.CMAKE_BUILD_TYPE = "RelWithDebInfo"
return {
	{ -- This plugin
		"Zeioth/compiler.nvim",
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
		dependencies = { "stevearc/overseer.nvim" },
		keys = {
			{ "<leader>M", "<cmd>CompilerOpen <cr>", desc = "Configure compile options" },
			{ "<leader>m", "<cmd>CompilerRedo <cr>", desc = "Redo last build" },
		},

		opts = {},
	},
	{ -- The task runner we use
		"stevearc/overseer.nvim",
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
		opts = {
			task_list = {
				direction = "right",
				--min_height = 25,
				--max_height = 25,
				--default_detail = 1,
			},
		},
	},
}
--]]
---[[
return {
	{
		"Civitasv/cmake-tools.nvim",
		keys = {
			{ "<leader>m", "<cmd>CMakeRun <cr>", desc = "Make+run with cmake-tools" },
		},
		config = function()
			require("cmake-tools").setup({
				-- this doesn't seem to actually work
				cmake_soft_link_compile_commands = true,
				cmake_build_directory = "build/${variant:buildType}",
				--cmake_executor = { name = "quickfix", opts = { show = "only_on_error", position = "horizontal" } },
				cmake_executor = {
					name = "overseer",
					opts = {
						new_task_opts = {
							strategy = {
								"toggleterm",
								open_on_start = false,
								quit_on_exit = "success",
							},
						},
					},
				},
				cmake_runner = {
					name = "overseer",
					opts = {
						new_task_opts = {
							strategy = {
								"toggleterm",
								--open_on_start = false,
								quit_on_exit = "success",
							},
						},
					},
				},
			})
		end,
	},
}
--]]
