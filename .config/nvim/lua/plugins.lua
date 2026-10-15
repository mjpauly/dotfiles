return {
    {
        'christoomey/vim-tmux-navigator',
        init = function()
            -- Mappings are defined in plugin/mru_navigate.lua, which resolves
            -- ambiguous moves by most-recently-visited window (like tmux).
            vim.g.tmux_navigator_no_mappings = 1
        end,
    },
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

    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        -- dependencies = { "nvim-tree/nvim-web-devicons" },
        -- or if using mini.icons/mini.nvim
        -- dependencies = { "echasnovski/mini.icons" },
        opts = {}
    },

    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {},
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate"
    },

    -- In-buffer rendering of markdown tables, headings, code blocks, etc.
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        ft = { "markdown" },
        opts = {
            heading = {
                -- No line backgrounds (looks like a diff). Rainbow* groups are
                -- defined in start.lua.
                backgrounds = {},
                foregrounds = {
                    "RainbowRed",
                    "RainbowYellow",
                    "RainbowBlue",
                    "RainbowGreen",
                    "RainbowViolet",
                    "RainbowCyan",
                },
            },
        },
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
    },

    {
        "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
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
