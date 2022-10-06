require("null-ls").setup({
    sources = {
        -- General
        require("null-ls").builtins.diagnostics.codespell.with{
            -- Disable cluster within the editor itsel
            diagnostic_config = {
                virtual_text = false,
                signs        = false,
            },
        },

        -- Python --
        -- Enable `mypy` integration
        require("null-ls").builtins.diagnostics.mypy.with{
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
        require("null-ls").builtins.diagnostics.flake8.with{
            -- Disable cluster within the editor itself
            diagnostic_config = {
                virtual_text = false,
                signs        = false,
            },
        },

        -- Use `black` as the formatter
        require("null-ls").builtins.formatting.black,
    },
})
