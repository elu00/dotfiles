-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- Disable autoformat for Python files
--[[vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "python" },
	callback = function()
		vim.b.autoformat = false
	end,
})
--]]
--[[
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "norg" },
	callback = function()
		vim.opt.spell = false
		--vim.bo.formatoptions = "tcqj"
	end,
})
]]
--
