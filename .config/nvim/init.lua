vim.cmd([[source ~/.vimrc]])

vim.opt.undodir = vim.fn.expand("$HOME") .. "/.nvim/undodir"

-- show error only in floating box
vim.diagnostic.config({
	underline = true,
	severity_sort = true,
	virtual_text = false,
	float = {
		source = "always", -- Or "if_many"
	},
})

local keymap = vim.keymap -- for conciseness
vim.keymap.set("n", "<C-e>", ":Explore<CR>", { desc = "open oil file explorer" })
keymap.set("n", "<leader>rs", ":LspRestart<CR>")
keymap.set("n", "K", vim.lsp.buf.hover) -- show documentation for what is under cursor
keymap.set("n", "gd", vim.lsp.buf.definition)
keymap.set("n", "gD", vim.lsp.buf.declaration)
keymap.set("n", "gi", vim.lsp.buf.implementation)
keymap.set("n", "gr", vim.lsp.buf.references)
keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
keymap.set("n", "<leader>dd", vim.diagnostic.open_float)
keymap.set("n", "<space>dl", vim.diagnostic.setloclist)
keymap.set("n", "[d", vim.diagnostic.goto_prev)
keymap.set("n", "]d", vim.diagnostic.goto_next)

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

local spec = {
	{ import = "common_plugins" },
}

-- If running in VSCode, add additional configuration or plugins
if vim.g.vscode then
	require("vscode_neovim")
else
	-- For non-VSCode setups, include other plugins
	table.insert(spec, { import = "plugins" })
end

-- Setup lazy.nvim
require("lazy").setup({
	spec = spec,
	install = { colorscheme = { "habamax" } },

	checker = { enabled = false },
})
