local telescope = require "telescope"
local actions   = require "telescope.actions"

telescope.setup{
    defaults = {
        mappings = {
            i = {
                -- Make <ESC> close the popup rather than exiting Insert mode
                ["<esc>"] = actions.close
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",
        },  -- telescope-fzf-native
        frecency = {
            default_workspace = "CWD"
        }
    }
}

-- Load extensions
telescope.load_extension("fzf")

-- Keybinds
vim.keymap.set("n", "<Leader>pp", "<Cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<Leader>pg", "<Cmd>Telescope git_files<CR>")

vim.keymap.set("n", "<Leader>ff", "<Cmd>Telescope live_grep<CR>")

vim.keymap.set("n", "<Leader>tn", "<Cmd>Telescope lsp_definitions<CR>")
vim.keymap.set("n", "<Leader>tm", "<Cmd>Telescope lsp_references<CR>")
