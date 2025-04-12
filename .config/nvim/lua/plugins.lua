return {
    'christoomey/vim-tmux-navigator',
    'tpope/vim-surround',
    'tpope/vim-repeat',
    'vim-scripts/argtextobj.vim',
    'tpope/vim-speeddating',
    'glts/vim-magnum',  -- dependency of radical
    'glts/vim-radical',
    'tpope/vim-fugitive',
    -- use 'APZelos/blamer.nvim'
    'morhetz/gruvbox',

    'lewis6991/gitsigns.nvim', -- sidebar indication of git changes

    -- lsp related below

    'neovim/nvim-lspconfig',

    -- Visualize lsp progress
    "j-hui/fidget.nvim",

    -- Autocompletion framework
    "hrsh7th/nvim-cmp",
    {
        -- cmp LSP completion
        "hrsh7th/cmp-nvim-lsp",
        -- cmp Snippet completion
        "hrsh7th/cmp-vsnip",
        -- cmp Path completion
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        dependencies = { "hrsh7th/nvim-cmp" },
    },
    -- See hrsh7th other plugins for more great completion sources!
    -- Snippet engine
    'hrsh7th/vim-vsnip',
    -- Adds extra functionality over rust analyzer
    {
        'mrcjkb/rustaceanvim',
        version = '^6', -- Recommended
        lazy = false, -- This plugin is already lazy
    },

    -- Optional
    -- use("nvim-lua/popup.nvim")
    -- use("nvim-lua/plenary.nvim")  -- required by telescope
    -- use("nvim-telescope/telescope.nvim")

    -- eslint setup for typescript
    -- more info: https://github.com/MunifTanjim/eslint.nvim
    -- disabled 2025-04-11 after upgrading to nvim 0.11.0
    -- 'nvim-lua/plenary.nvim',
    -- 'jose-elias-alvarez/null-ls.nvim',
    -- 'MunifTanjim/eslint.nvim',
    -- 'MunifTanjim/prettier.nvim',

}
