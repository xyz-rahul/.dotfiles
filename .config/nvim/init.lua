-- ordinary Neovim
require("keymap")
require("vim-options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")

if vim.g.vscode then
	-- VSCode extension
	vim.g.mapleader = " "
	local vscode = require("vscode")

	vim.keymap.set({ "n", "x" }, "<leader>r", function()
		vscode.with_insert(function()
			vscode.action("editor.action.refactor")
		end)
	end)

	vim.keymap.set({ "n" }, "<leader>fm", function()
		vscode.action("editor.action.formatDocument")
	end)

	vim.keymap.set({ "x" }, "<leader>fm", function()
		vscode.action("editor.action.formatSelection")
	end)

	vim.keymap.set({ "n" }, "<leader>ff", function()
		vscode.action("workbench.action.quickOpen")
	end)
	vim.keymap.set({ "n" }, "<leader>lg", function()
		vscode.action("workbench.action.findInFiles")
	end)

	vim.keymap.set({ "n", "x" }, "<leader>x", function()
		vscode.action("workbench.action.closeActiveEditor")
	end)

	vim.keymap.set({ "n" }, "<leader>dd", function()
		vscode.action("workbench.actions.view.problems")
	end)

	vim.keymap.set({ "n", "v" }, "zc", function()
		vscode.action("editor.fold")
	end)
	vim.keymap.set({ "n", "v" }, "zC", function()
		vscode.action("editor.foldRecursively")
	end)
	vim.keymap.set({ "n", "v" }, "zo", function()
		vscode.action("editor.unfold")
	end)
	vim.keymap.set({ "n", "v" }, "zO", function()
		vscode.action("editor.unfoldRecursively")
	end)
	vim.keymap.set({ "n", "v" }, "za", function()
		vscode.action("editor.toggleFold")
	end)
end
