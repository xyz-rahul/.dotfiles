vim.g.mapleader = " "
local vscode = require("vscode")

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
vim.keymap.set({ "n" }, "gr", function()
	vscode.action("editor.action.referenceSearch.trigger")
end)
vim.keymap.set({ "n" }, "gD", function()
	vscode.action("editor.action.revealDeclaration")
end)

vim.keymap.set({ "n", "x" }, "<leader>x", function()
	vscode.action("workbench.action.closeActiveEditor")
end)

vim.keymap.set({ "n" }, "<leader>dd", function()
	vscode.action("workbench.actions.view.problems")
end)
vim.keymap.set({ "n" }, "<leader>ca", function()
	vscode.action("editor.action.quickFix")
end)

vim.keymap.set({ "n" }, "<leader>dl", function()
	vscode.action("workbench.actions.view.problems")
	vscode.action("workbench.action.focusActiveEditorGroup")
end)
vim.keymap.set({ "n" }, "]d", function()
	vscode.action("editor.action.marker.next")
end)
vim.keymap.set({ "n" }, "[d", function()
	vscode.action("editor.action.marker.prev")
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