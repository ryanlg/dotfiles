require("trouble").setup { }

vim.keymap.set("n", "<Leader>tt", "<Cmd>TroubleToggle document_diagnostics<CR>")
