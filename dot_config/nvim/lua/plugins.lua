return require("packer").startup(function()
    use {
        "wbthomason/packer.nvim",
        config = [[require "config.packer"]]
    }


    -- Search
    use {
        {
            "nvim-telescope/telescope.nvim",
            requires = {
                "nvim-lua/popup.nvim",
                "nvim-lua/plenary.nvim",
                "telescope-fzf-native.nvim",
                "nvim-telescope/telescope-ui-select.nvim",
            },
            wants = {
                "popup.nvim",
                "plenary.nvim",
                "telescope-fzf-native.nvim",
                "telescope-ag"
            },
            -- setup = [[require("config.telescope_setup")]],
            config = [[require "config.telescope"]],
        },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make",
        },
        {
            "kelly-lin/telescope-ag",
        }
    }  -- Fuzzy search

    use {
        "andymass/vim-matchup",
        config = [[require "config.matchup"]],
    }  -- Better % match up


    -- Movement
    -- use "justinmk/vim-sneak" -- s<char><char> to replace f key


    -- Editing
    use {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    }  -- "gc" to comment visual regions/lines

    use "machakann/vim-sandwich"  -- Wrap words in (), "", etc.


    -- Syntax & LSP
    use {
        "nvim-treesitter/nvim-treesitter",
        config = [[require "config.treesitter"]],
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }
    use {
        "neovim/nvim-lspconfig",
        config = [[require "config.lsp"]],
    }
    use {
        "jose-elias-alvarez/null-ls.nvim",
        config = [[require "config.null_ls"]],
        requires = { "nvim-lua/plenary.nvim" },
    }  -- Bridge common tools to LSP
    use "Vimjas/vim-python-pep8-indent"  -- Better indentation for Python


    -- UI
    use {
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons", -- optional, for file icon
        },
        tag = "nightly", -- optional, updated every week. (see issue #1193)
        config = [[require "config/nvim_tree"]]
    }  -- File Explorer


    -- Visuals
    -- use {
    --     "lukas-reineke/indent-blankline.nvim",
    --     config = [[require "config.indent_blankline"]]
    -- }  -- Indent guides
    use "kyazdani42/nvim-web-devicons"  -- Pretty icons
    use "ryanlg/lights-off"  -- Your own custom theme
    use {
        "EdenEast/nightfox.nvim",
        config = [[
            require "config/nightfox"
            vim.cmd 'colorscheme carbonfox'
        ]]
    }
    use {
        "nvim-lualine/lualine.nvim",
        config = [[require "config.lualine"]]
    }  -- Status line
    use {
        "folke/zen-mode.nvim",
        config = [[require "config.zen"]]
    }  -- Focus mode, similar to Goyo
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = [[require "config/trouble"]],
    }  -- Better diagonistic display
end)
