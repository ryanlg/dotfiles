null_ls = require("null-ls")

-- Taken from github.com/jose-elias-alvarez/null-ls.nvim/issues/1131
-- Below is a workaround for a conflict between `null-ls` and nvim's new
-- handling of `formatexpr` in 0.8, which causes `gq` to be a no-op.
-- This workaround essentially prevent `null-ls` from taking responsibility
-- of formatting.
local function is_null_ls_formatting_enabed(bufnr)
    local file_type = vim.api.nvim_buf_get_option(bufnr, "filetype")
    local generators = require("null-ls.generators").get_available(
        file_type,
        require("null-ls.methods").internal.RANGE_FORMATTING
    )
    return #generators > 0
end

null_ls.setup({
    sources = {
        -- General
        null_ls.builtins.diagnostics.codespell.with{
            -- Disable cluster within the editor itself
            diagnostic_config = {
                virtual_text = false,
                signs        = false,
            },
        },

        -- Python --
        -- Enable `mypy` integration
        null_ls.builtins.diagnostics.mypy.with{
            -- Disable cluster within the editor itself
            diagnostic_config = {
                virtual_text = false,
                signs        = false,
            },
            extra_args = {
                "--strict",  -- PACT usually does this
            },
            runtime_condition = function(params)
                -- Do no run mypy in tests.
                return not params.bufname:match("tests/test_.*%.py")
            end,
        },

        -- Enable `flake8`
        null_ls.builtins.diagnostics.flake8.with{
            -- Disable cluster within the editor itself
            diagnostic_config = {
                virtual_text = false,
                signs        = false,
            },
        },

        -- Use `yapf` as the range formatter
        -- null_ls.builtins.formatting.yapf.with{
        --     -- Disable global formatting for YAPF. That is up to `black`.
        --     method = require("null-ls.methods").internal.RANGE_FORMATTING,
        -- },

        -- Use `black` as the buffer formatter
        null_ls.builtins.formatting.black,
    },

    -- Taken from github.com/jose-elias-alvarez/null-ls.nvim/issues/1131
    on_attach = function(client, bufnr)
        if client.server_capabilities.documentFormattingProvider then
            if 
                client.name == "null-ls" and is_null_ls_formatting_enabed(bufnr)
                or client.name ~= "null-ls" then
                    vim.api.nvim_buf_set_option(
                        bufnr,
                        "formatexpr",
                        "v:lua.vim.lsp.formatexpr()"
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>gq",
                        "<cmd>lua vim.lsp.buf.format({ async = true })<CR>",
                        opts
                    )
                else
                    vim.api.nvim_buf_set_option(bufnr, "formatexpr", "")
            end
        end
    end
})
