return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
			},
		})
		-- vim.keymap.set({ "n", "v" }, "<leader>fm", function()
		-- 	require("conform").format({ async = true }, function(err)
		-- 		if not err then
		-- 			local mode = vim.api.nvim_get_mode().mode
		-- 			if vim.startswith(string.lower(mode), "v") then
		-- 				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
		-- 			end
		-- 		end
		-- 	end)
		-- end, { desc = "Format code" })
        vim.keymap.set({ "n", "v" }, "<leader>fm", function()
			require("conform").format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,

}
