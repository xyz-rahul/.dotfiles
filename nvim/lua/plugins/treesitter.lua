return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "bash", "c", "cpp", "css", "dockerfile", "go", "graphql", "haskell", 'html', 'http', "java", "javascript", "typescript", "jq", "jsdoc", "json", "kotlin", "lua", "nginx", "php", "prisma", "python", "rust", "yaml" },
                enable = true,
                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,
                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
                indent = { enable = true },
                highlight = {
                    -- `false` will disable the whole extension
                    enable = true,
                },
            })
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        opts = {},
    },
}
