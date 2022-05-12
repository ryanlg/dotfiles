require("indent_blankline").setup{
    enabled = false  -- Disable by default. Toggle on when needed.
}

vim.keymap.set("n", "<Leader>vd", "<Cmd>IndentBlanklineToggle<CR>")
