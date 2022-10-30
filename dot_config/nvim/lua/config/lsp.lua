-- Load Pyright for LSP
-- Note that we will only use Pyright for its code parsing and AST stuff, e.g.
-- definitions, references, etc. Type checking is still handed to `mypy`.
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
      ignore = "**",
      python = {
        ignore = "**",
        analysis = {
            typeCheckingMode = "off",
        },
      },
    },
}

vim.keymap.set('n', '<Leader>tf', function() vim.lsp.buf.format { async = true } end)

-- We don't want diagnostics, but Pyright doesn't have a way to turn them off.
-- So, we will filter them out here.
-- Taken from github.com/neovim/nvim-lspconfig/issues/726
function filter(arr, func)
    -- Filter in place
    -- https://stackoverflow.com/questions/49709998/how-to-filter-a-lua-array-inplace
    local new_index = 1
    local size_orig = #arr
    for old_index, v in ipairs(arr) do
        if func(v, old_index) then
            arr[new_index] = v
            new_index = new_index + 1
        end
    end
    for i = new_index, size_orig do arr[i] = nil end
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    function (a, params, client_id, c, config)
        filter(params.diagnostics, function (diagnostic)
            if diagnostic.source == "Pyright" then
                return false
            end

            return true
        end)
        vim.lsp.diagnostic.on_publish_diagnostics(a, params, client_id, c, config)
    end,
    {}
)
