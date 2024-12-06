return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require('gitsigns').setup {
            current_line_blame           = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts      = {
                delay = 100,
            },
            current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        }

        vim.keymap.set('v', '<leader>Hs', ':Gitsigns stage_hunk<CR>')
        vim.keymap.set({ 'n', 'v' }, '<leader>Hr', ':Gitsigns reset_hunk<CR>')
        vim.keymap.set('n', '<leader>Hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
        vim.keymap.set('n', '<leader>Hp', '<cmd>Gitsigns preview_hunk<CR>')
        vim.keymap.set('n', '<leader>Hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
        vim.keymap.set('n', '<leader>Hd', '<cmd>Gitsigns diffthis<CR>')
        vim.keymap.set('n', '<leader>HD', '<cmd>Gitsigns toggle_deleted<CR>')
    end

}
