-- install and update with :PackerUpdate (PackerCompile and other cmds don't
-- seem to work)

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'christoomey/vim-tmux-navigator'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'vim-scripts/argtextobj.vim'
    use 'tpope/vim-speeddating'
    use 'glts/vim-magnum'  -- dependency of radical
    use 'glts/vim-radical'
    use 'tpope/vim-fugitive'
    -- use 'APZelos/blamer.nvim'
    use 'morhetz/gruvbox'

    -- Rust LSP setup

    use 'neovim/nvim-lspconfig'

    -- Visualize lsp progress
    use({
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup()
        end
    })

    -- Autocompletion framework
    -- -- [[
    use("hrsh7th/nvim-cmp")
    use({
        -- cmp LSP completion
        "hrsh7th/cmp-nvim-lsp",
        -- cmp Snippet completion
        "hrsh7th/cmp-vsnip",
        -- cmp Path completion
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        after = { "hrsh7th/nvim-cmp" },
        requires = { "hrsh7th/nvim-cmp" },
    })
    -- See hrsh7th other plugins for more great completion sources!
    -- Snippet engine
    use('hrsh7th/vim-vsnip')
    -- ]]--
    -- Adds extra functionality over rust analyzer
    use("simrat39/rust-tools.nvim")

    -- Optional
    -- use("nvim-lua/popup.nvim")
    -- use("nvim-lua/plenary.nvim")  -- required by telescope
    -- use("nvim-telescope/telescope.nvim")

    -- eslint setup for typescript
    -- more info: https://github.com/MunifTanjim/eslint.nvim
    use('nvim-lua/plenary.nvim')
    use('jose-elias-alvarez/null-ls.nvim')
    use('MunifTanjim/eslint.nvim')
    use('MunifTanjim/prettier.nvim')

    -- sidebar indication of git changes
    use('lewis6991/gitsigns.nvim')

end)


