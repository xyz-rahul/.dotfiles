return {
	"stevearc/oil.nvim",
	opts = {},
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			default_file_explorer = false,

			delete_to_trash = true,
			columns = {
				"icon",
				-- "permissions",
				-- "size",
				-- "mtime",
			},

			win_options = {
				signcolumn = "no",
				cursorcolumn = true,
				foldcolumn = "0",
				spell = false,
				list = true,
				conceallevel = 3,
				concealcursor = "nvic",
			},
			keymaps = {
				["<C-?>"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-\\>"] = "actions.select_vsplit",
				["<C-->"] = "actions.select_split",
				["<C-t>"] = "actions.select_tab",
				["<C-p>"] = "actions.preview",
				["<C-x>"] = "actions.close",
				["<C-l>"] = "actions.refresh",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["<C-s>"] = "actions.change_sort",
				["<C-o>"] = "actions.open_external",
				["<C-h>"] = "actions.toggle_hidden",
				["<C-/>"] = "actions.toggle_trash",
			},

			view_options = {
				-- Show files and directories that start with "."
				show_hidden = true,
				-- This function defines what is considered a "hidden" file
				is_hidden_file = function(name, bufnr)
					return vim.startswith(name, ".")
				end,
				-- This function defines what will never be shown, even when `show_hidden` is set
				is_always_hidden = function(name, bufnr)
					return false
				end,
			},
		})
	end,
}
