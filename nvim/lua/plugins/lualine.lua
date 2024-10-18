return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- Eviline config for lualine
		-- Author: shadmansaleh
		-- Credit: glepnir
		local lualine = require("lualine")

        -- Color table for highlights
        -- stylua: ignore
        local colors = {
          bg       = '#202328',
          fg       = '#bbc2cf',
          yellow   = '#ECBE7B',
          cyan     = '#008080',
          darkblue = '#081633',
          green    = '#98be65',
          orange   = '#FF8800',
          violet   = '#a9a1e1',
          magenta  = '#c678dd',
          blue     = '#51afef',
          red      = '#ec5f67',
        }

		local conditions = {
			buffer_not_empty = function()
				return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
			end,
			hide_in_width = function()
				return vim.fn.winwidth(0) > 80
			end,
			check_git_workspace = function()
				local filepath = vim.fn.expand("%:p:h")
				local gitdir = vim.fn.finddir(".git", filepath .. ";")
				return gitdir and #gitdir > 0 and #gitdir < #filepath
			end,
		}

		-- Config
		local config = {
			options = {
				-- Disable sections and component separators
				component_separators = "",
				section_separators = "",
				theme = {
					-- We are going to use lualine_c an lualine_x as left and
					-- right section. Both are highlighted by c theme .  So we
					-- are just setting default looks o statusline
					normal = { c = { fg = colors.fg, bg = colors.bg } },
					inactive = { c = { fg = colors.fg, bg = colors.bg } },
				},
			},
			sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				-- These will be filled later
				lualine_c = {},
				lualine_x = {},
			},
			inactive_sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
		}

		-- Inserts a component in lualine_c at left section
		local function ins_left(component)
			table.insert(config.sections.lualine_c, component)
		end

		-- Inserts a component in lualine_x at right section
		local function ins_right(component)
			table.insert(config.sections.lualine_x, component)
		end

		ins_left({
			function()
				return "▊"
			end,
			color = { fg = colors.blue }, -- Sets highlighting of component
			padding = { left = 0, right = 1 }, -- We don't need space before this
		})


		ins_left({
			"branch",
			icon = "",
			color = { fg = colors.violet, gui = "bold" },
		})


		ins_left({
			"filename",
            path = 3,
			cond = conditions.buffer_not_empty,
			color = { fg = colors.magenta, gui = "bold" },
		})



		ins_left({
			"diff",
			-- Is it me or the symbol for modified us really weird
			symbols = { added = "+", modified = "~", removed = "-" },
			diff_color = {
				added = { fg = colors.green },
				modified = { fg = colors.orange },
				removed = { fg = colors.red },
			},
			cond = conditions.hide_in_width,
		})

		ins_left({
			function()
				return "%="
			end,
		})


		-- Add components to right sections
		ins_right({
			"diagnostics",
			sources = { "nvim_diagnostic" },
			symbols = { error = "E ", warn = "W ", info = "I " },
			diagnostics_color = {
				color_error = { fg = colors.red },
				color_warn = { fg = colors.yellow },
				color_info = { fg = colors.cyan },
			},
		})
		ins_right({
			-- filesize component
			"filesize",
			cond = conditions.buffer_not_empty,
		})
		ins_right({ "location", color = { fg = colors.fg, gui = "bold" } })
		ins_right({ "progress", color = { fg = colors.fg, gui = "bold" } })
		ins_right({
			"o:encoding", -- option component same as &encoding in viml
			fmt = string.upper, -- I'm not sure why it's upper case either ;)
			cond = conditions.hide_in_width,
			color = { fg = colors.green, gui = "bold" },
		})

		ins_right({
			function()
				return "▊"
			end,
			color = { fg = colors.blue },
			padding = { left = 1 },
		})

		-- Now don't forget to initialize lualine
		lualine.setup(config)
	end,
}
