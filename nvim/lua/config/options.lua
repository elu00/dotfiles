-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
if vim.g.neovide then
	vim.o.guifont = "Iosevka Term SS04:h18"
end
vim.opt.relativenumber = false
vim.opt.conceallevel = 2
vim.opt.undofile = false
vim.opt.clipboard = ""
vim.opt.spell = true
vim.opt.linebreak = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.wrap = true
-- https://github.com/CharlesChiuGit/nvimdots.lua/blob/main/lua/core/options.lua
local function isempty(s)
	return s == nil or s == ""
end
local function use_if_defined(val, fallback)
	return val ~= nil and val or fallback
end
-- custom python provider
local conda_prefix = os.getenv("CONDA_PREFIX")
if not isempty(conda_prefix) then
	vim.g.python_host_prog = use_if_defined(vim.g.python_host_prog, conda_prefix .. "/bin/python")
	vim.g.python3_host_prog = use_if_defined(vim.g.python3_host_prog, conda_prefix .. "/bin/python")
else
	vim.g.python_host_prog = use_if_defined(vim.g.python_host_prog, "python")
	vim.g.python3_host_prog = use_if_defined(vim.g.python3_host_prog, "python3")
end
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.lazyvim_python_lsp = "ruff"
vim.g.lazyvim_python_ruff = "ruff"
--vim.opt.foldmethod = "syntax"
--vim.diagnostic.config({ virtual_text = false, virtual_lines = false })
