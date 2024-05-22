return {
	"simrat39/symbols-outline.nvim",
	config = function()
		local opts = {
			highlight_hovered_item = true,
			show_guides = true,
			auto_preview = false,
			position = "right",
			relative_width = true,
			width = 50,
			auto_close = false,
			show_numbers = true,
			show_relative_numbers = true,
			show_symbol_details = true,
			preview_bg_highlight = "Pmenu",
			autofold_depth = nil,
			auto_unfold_hover = true,
			fold_markers = { "", "" },
			wrap = false,
			keymaps = { -- These keymaps can be a string or a table for multiple keys
				close = { "<Esc>", "q" },
				goto_location = "<Cr>",
				focus_location = "o",
				hover_symbol = "K",
				toggle_preview = "P",
				rename_symbol = "r",
				code_actions = "<leader>ca",
				fold = "zc",
				unfold = "zo",
				fold_all = "zC",
				unfold_all = "zA",
			},
		}
		require("symbols-outline").setup(opts)
		vim.keymap.set({ "n" }, "<leader>o", ":SymbolsOutline<CR>", { desc = "outline of context" })
	end,
}
