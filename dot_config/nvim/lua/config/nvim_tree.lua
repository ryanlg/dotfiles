require("nvim-tree").setup({
    filters = {
        exclude = {
            "\\.tox$",
        },
        custom = {
            "^__pycache__$",
            "^\\.mypy_cache$",
        },
    },
})

vim.keymap.set("n", "<C-\\>", "<Cmd>NvimTreeToggle<CR>")
