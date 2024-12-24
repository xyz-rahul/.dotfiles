return {
    "simrat39/symbols-outline.nvim",
    config = function()
        local opts = {
            highlight_hovered_item = true,
        }
        require("symbols-outline").setup(opts)
        vim.keymap.set({ "n" }, "<leader>o", ":SymbolsOutline<CR>", { desc = "outline of context" })
    end,
}
