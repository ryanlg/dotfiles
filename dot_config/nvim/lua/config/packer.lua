-- Automatically run `PackerCompile` when `plugins.lua` is updated.
local packer_auto_compile_id = vim.api.nvim_create_augroup(
    "packer_auto_compile",
    { clear = true }
)

vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        group   = packer_auto_compile_id,
        pattern = "plugins.lua",
        command = [[source <afile> | PackerCompile]],
    }
)
