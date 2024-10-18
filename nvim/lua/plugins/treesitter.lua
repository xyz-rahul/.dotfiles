return {
	{
		"nvim-treesitter/nvim-treesitter",
		cmd = {
			"TSInstall",
			"TSBufEnable",
			"TSBufDisable",
			"TSModuleInfo",
			"TSContextEnable",
			"TSContextDisable",
			"TSContextToggle",
		},
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"html",
					"lua",
					"javascript",
					"typescript",
					"java",
					"comment",
					"python",
					"vimdoc",
					"c",
					"lua",
					"rust",
					"bash",
				},

				enable = true,
				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,
				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
				auto_install = true,

				indent = { enable = true },

				highlight = {
					-- `false` will disable the whole extension
					enable = true,

					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = { "markdown" },
					use_languagetree = true,
				},
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                max_lines = 3,
                line_numbers = false,
				separator = "─",
			})

			vim.cmd([[
                    highlight TreesitterContext guibg=#2E3440 
                    highlight TreesitterContextLineNumberBottom gui=underline guisp=Grey
            ]])
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		opts = {},
	},
}
