vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false

-- Disable backup files
vim.opt.backup = false

vim.opt.undodir = vim.fn.expand("$HOME") .. "/.vim/undodir"

vim.opt.undofile = true

vim.opt.hlsearch = false

vim.opt.incsearch = true

vim.opt.ignorecase = true
vim.opt.termguicolors = true

vim.opt.scrolloff = 16

vim.opt.signcolumn = "yes"

-- Allow filenames to contain '@'
vim.opt.isfname:append("@-@")

-- Set the time in milliseconds for triggering CursorHold events (50ms)
vim.opt.updatetime = 50

vim.o.termguicolors = true

-- Highlight column 80 to help with code formatting
vim.opt.colorcolumn = "80"

-- show error only in floating box
vim.diagnostic.config({
	underline = true,
	severity_sort = true,
	virtual_text = false,
	float = {
		source = "always", -- Or "if_many"
	},
})

-- highlight cursorline
vim.opt.cursorline = true

vim.opt.mouse = "a"

-- vim.opt.foldenable = false
