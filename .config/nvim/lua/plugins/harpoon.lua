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

        vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
        vim.keymap.set("n", "<leader>H", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        vim.keymap.set("n", "<leader>1", function() require("harpoon"):list():select(1) end)
        vim.keymap.set("n", "<leader>2", function() require("harpoon"):list():select(2) end)
        vim.keymap.set("n", "<leader>3", function() require("harpoon"):list():select(3) end)
        vim.keymap.set("n", "<leader>4", function() require("harpoon"):list():select(4) end)
        vim.keymap.set("n", "<leader>5", function() require("harpoon"):list():select(5) end)
        vim.keymap.set("n", "<leader>6", function() require("harpoon"):list():select(6) end)
        vim.keymap.set("n", "<leader>7", function() require("harpoon"):list():select(7) end)
        vim.keymap.set("n", "<leader>8", function() require("harpoon"):list():select(8) end)
        vim.keymap.set("n", "<leader>9", function() require("harpoon"):list():select(9) end)
        vim.keymap.set("n", "<leader>0", function() require("harpoon"):list():select(10) end)
    end,
}
