return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- calling `setup` is optional for customization
		require("fzf-lua").setup({ "fzf-native" })
		-- Set key mappings using vim.api.nvim_set_keymap
		vim.api.nvim_set_keymap(
			"n",
			"<leader>ff",
			"<cmd>lua require('fzf-lua').files({ fzf_opts = {['--layout'] = 'reverse-list'} })<cr>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>lg",
			"<cmd>lua require'fzf-lua'.live_grep()<cr>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>gg",
			"<cmd>lua require'fzf-lua'.live_grep({ cmd = 'git grep --line-number --column --color=always' })<cr>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>gf",
			"<cmd>lua require('fzf-lua').git_files()<cr>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>gs",
			"<cmd>lua require('fzf-lua').git_status()<cr>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>gc",
			"<cmd>lua require('fzf-lua').git_commits()<cr>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>gb",
			"<cmd>lua require('fzf-lua').git_bcommits()<cr>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>gB",
			"<cmd>lua require('fzf-lua').git_branches()<cr>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>gS",
			"<cmd>lua require('fzf-lua').git_stash()<cr>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>gt",
			"<cmd>lua require('fzf-lua').git_tags()<cr>",
			{ noremap = true, silent = true }
		)
	end,
}
