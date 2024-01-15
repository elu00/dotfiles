vim.g.CMAKE_BUILD_TYPE = "RelWithDebInfo"
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
