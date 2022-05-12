-- Load Pyright for LSP
require("lspconfig").pyright.setup{}

-- Disable error messages display within the buffer
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text     = false,
        update_in_insert = false,
        signs            = function() end
    }
)
