return {
    "phaazon/hop.nvim",
    branch = "v2", -- optional but strongly recommended
    config = function()
        require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })

        vim.keymap.set({ "v", "n" }, "ss", "<cmd>HopWord<CR>", { desc = "hop to word" })
        vim.cmd("hi HopNextKey guifg=#ff9900")
        vim.cmd("hi HopNextKey1 guifg=#ff9900")
        vim.cmd("hi HopNextKey2 guifg=#ff9900")
    end,
}
