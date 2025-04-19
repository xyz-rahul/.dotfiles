return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		opts = {},
	},
	-- LSP
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "saghen/blink.cmp" },
		},
		init = function()
			-- Reserve a space in the gutter
			-- This will avoid an annoying layout shift in the screen
			vim.opt.signcolumn = "yes"
		end,
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			require("mason-lspconfig").setup({
				ensure_installed = {},
				automatic_installation = true,
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({ capabilites = capabilities })
					end,
				},
			})
		end,
	},
	-- autopairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			-- "giuxtaposition/blink-cmp-copilot",
		},
        version = '1.*',
		opts = {
			keymap = { preset = "default",
            ['<CR>'] = { 'accept', 'fallback' }
            },
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			-- Displays a preview of the selected item on the current line
			signature = { enabled = true },
			sources = {
				default = { "lsp", 
                "path", 
                "snippets", 
                "buffer", 
                -- "copilot" 
            },
				providers = {
					-- copilot = {
					-- 	name = "copilot",
					-- 	module = "blink-cmp-copilot",
					-- 	async = true,
					-- },
				},
			},
			completion = {
				accept = {},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 100,
				},
                list = {
                     selection = { 
                          preselect = true,
                          auto_insert = true,
                     }
                }
			},
		},
	},
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	config = function()
	-- 		require("copilot").setup({
	-- 			suggestion = { enabled = false },
	-- 			panel = { enabled = false },
	-- 		})
	-- 	end,
	-- },
}
