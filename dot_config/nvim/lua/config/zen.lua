require("zen-mode").setup{
    window = {
        height = 0.85,
        options = {
            list = true,       -- Show invisible characters
            number = false,    -- Disable line number column
        }
    }
}

vim.keymap.set("n", "<Leader>g", "<Cmd>ZenMode<CR>")
