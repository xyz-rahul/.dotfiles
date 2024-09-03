vim.cmd [[source ~/.vimrc]]

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
vim.keymap.set("n", "<C-e>", ":Oil<CR>", { desc = "open oil file explorer" })

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

if vim.g.vscode then
	-- Setup lazy.nvim
	require("lazy").setup({
		spec = {
			-- import your plugins
			{ import = "common_plugins" },
		},
		-- Configure any other settings here. See the documentation for more details.
		-- automatically check for plugin updates
		checker = { enabled = false },
	})

	require("vscode_neovim")
else
	-- Setup lazy.nvim
	require("lazy").setup({
		spec = {
			-- import your plugins
			{ import = "plugins" },
			{ import = "common_plugins" },
		},
		-- Configure any other settings here. See the documentation for more details.
		-- automatically check for plugin updates
		checker = { enabled = false },
	})
end
