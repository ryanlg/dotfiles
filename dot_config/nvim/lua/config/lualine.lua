-- Get rid of the colors in mode section.
local lualine_theme = require "lualine.themes.onedark"
lualine_theme.normal.a   = lualine_theme.normal.b
lualine_theme.insert.a   = lualine_theme.normal.b
lualine_theme.visual.a   = lualine_theme.normal.b
lualine_theme.replace.a  = lualine_theme.normal.b
lualine_theme.command.a  = lualine_theme.normal.b
lualine_theme.inactive.a = lualine_theme.normal.b

require("lualine").setup{
    options = {
        theme = lualine_theme,
        component_separators = { left = "", right = ""},
        section_separators = { left = "", right = ""},
    }
}
