require("trouble").setup { }

vim.keymap.set("n", "<Leader>tt", "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>")
