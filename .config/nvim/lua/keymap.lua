vim.g.mapleader = " "

vim.keymap.set("i", "jj", "<Esc>", { desc = "Map jj to escape in insert mode" })

vim.keymap.set("n", "<C-e>", ":Oil<CR>", { desc = "open oil file explorer" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down in visual mode" })

-- Visual mode: Move the selected lines up
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up in visual mode" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join current line with line below" })

-- Set up key mapping for scrolling down and centering the current line
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Set up key mapping for scrolling up and centering the current line
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv", { desc = "Move to next search result and center the screen" })

vim.keymap.set("n", "N", "Nzzzv", { desc = "Move to previous search result and center the screen" })

vim.keymap.set("x", "<leader>p", [["_dP"]], { desc = "Cut and paste to black hole register in visual mode" })

-- Normal and visual mode: Yank to the system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y"]], { desc = "Yank to system clipboard in normal and visual mode" })

vim.keymap.set("n", "<leader>Y", [["+Y"]], { desc = "Yank to system clipboard from current line to end of file" })

vim.keymap.set(
	{ "n", "v" },
	"<leader>d",
	[["_d"]],
	{ desc = "Delete to black hole register in normal and visual mode" }
)

-- Insert mode: Map Ctrl+C to escape, a commonly used key sequence for leaving insert mode
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Map Ctrl+C to escape in insert mode" })

-- Normal mode: Jump to the next location list item and center the screen
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Jump to next location list item and center the screen" })

-- Normal mode: Substitute the word under the cursor globally with confirmation
vim.keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Substitute word globally with confirmation" }
)

-- Normal mode: Reload the current file
vim.keymap.set("n", "<leader>rl", function()
	vim.cmd("so")
end, { desc = "Reload the current file" })

-- Buffers
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Switch to the previous buffer" })
vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Switch to the next buffer" })

-- Clear highlights
vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear highlights" })

-- Window
vim.keymap.set("n", "<leader>x", ":bd <CR>", { desc = "Close buffer", remap = true })
