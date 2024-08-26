return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	config = function()
		vim.o.foldcolumn = "0" -- '0' is not bad
		vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true

		vim.keymap.set("n", "K", function()
			local winid = require("ufo").peekFoldedLinesUnderCursor()
			if not winid then
				-- choose one of coc.nvim and nvim lsp
				vim.fn.CocActionAsync("definitionHover") -- coc.nvim
				vim.lsp.buf.hover()
			end
		end)

		require("ufo").setup()
	end,
}
