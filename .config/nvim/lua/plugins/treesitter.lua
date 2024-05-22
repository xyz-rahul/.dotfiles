return {
	{
		"nvim-treesitter/nvim-treesitter",
		--init = function()
		--end,
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		opts = function()
			local options = {
				ensure_installed = {
					"html",
					"lua",
					"javascript",
					"jsdoc",
					"typescript",
					"sql",
					"java",
					"comment",
					"python",
				},

				highlight = {
					enable = true,
					use_languagetree = true,
				},

				indent = { enable = true },
			}

			return options
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		enabled = true,
		opts = { mode = "cursor", max_lines = 3 },
		config = function()
			require("treesitter-context").setup({
				enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
				max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index  of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})
			vim.cmd("hi TreesitterContextBottom gui=underline guisp=red")
			vim.cmd("hi TreesitterContextLineNumberBottom gui=underline guisp=red")

			vim.keymap.set({ "n" }, "<leader>t", ":TSContextToggle<CR>", { desc = "toggle context sticky bar" })
		end,
	},

	{
		"windwp/nvim-ts-autotag",
		opts = {},
	},
}
