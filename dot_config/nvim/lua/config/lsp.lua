-- Load Pyright for LSP
local pyright_on_attach = function(client, bufnr)
  -- Taken from github.com/neovim/nvim-lspconfig
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<Leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
end

require("lspconfig").pyright.setup{
    on_attach = pyright_on_attach,
    settings = {
      python = {
        analysis = {
            typeCheckingMode = off,
        },
      },
    },
}

vim.keymap.set('n', '<Leader>tf', function() vim.lsp.buf.format { async = true } end)
