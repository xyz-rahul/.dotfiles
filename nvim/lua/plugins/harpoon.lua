return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()
		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end)

		vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "[h", function() harpoon:list():prev() end)
        vim.keymap.set("n", "]h", function() harpoon:list():next() end)

		vim.keymap.set("n", "<leader>1", function() require("harpoon"):list():select(1) end )
		vim.keymap.set("n", "<leader>2", function() require("harpoon"):list():select(2) end )
		vim.keymap.set("n", "<leader>3", function() require("harpoon"):list():select(3) end )
		vim.keymap.set("n", "<leader>4", function() require("harpoon"):list():select(4) end )
		vim.keymap.set("n", "<leader>5", function() require("harpoon"):list():select(5) end )
	end,
}
