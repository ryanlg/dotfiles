-- Config for EdenEast/nightfox.nvim
-- You have overridden the theme (`nightfox` style) to be your own monochrome
-- theme that you have always used.
--
-- This config is based on github.com/EdenEast/nightfox.nvim/blob/5a774636/readme.md?plain=1#L176

local C = require("nightfox.lib.color")
local Shade = require("nightfox.lib.shade")

-- Base colors
local base = {
  fgc     = C("#c7c7c7"),
  bgc     = C("#1c1c1c"),
  selc    = C("#858585"),

  black   = Shade.new("#272c33", 0.15, -0.15),
  red     = Shade.new("#e27167", 0.15, -0.15),
  green   = Shade.new("#a7cb8b", 0.15, -0.15),
  yellow  = Shade.new("#daaa78", 0.15, -0.15),
  blue    = Shade.new("#84c6f5", 0.15, -0.15),
  magenta = Shade.new("#d190e3", 0.15, -0.15),
  cyan    = Shade.new("#65c1cd", 0.15, -0.15),
  white   = Shade.new("#b9bfca", 0.15, -0.15),
  orange  = Shade.new("#f7c08d", 0.15, -0.15),
  pink    = Shade.new("#f8c8dc", 0.15, -0.15),
}

-- Palettes are the base color defines of a colorscheme.
-- You can override these palettes for each colorscheme defined by nightfox.
local palettes = {
  -- Everything defined under `all` will be applied to each style.
  -- all = {
  --   -- Each palette defines these colors:
  --   --   black, red, green, yellow, blue, magenta, cyan, white, orange, pink
  --   --
  --   -- These colors have 3 shades: base, bright, and dim
  --   --
  --   Defining just a color defines it's base color
  --   red = "#ff0000",
  --   black = { base = "#444444", bright = "#262626", dim = "#262626", },
  -- },
  -- nightfox = {
  --   -- A specific style's value will be used over the `all`'s value
  --   red = "#000f6d",
  -- },
  -- dayfox = {
  --   -- Defining multiple shades is done by passing a table
  --   blue = { base = "#4d688e", bright = "#4e75aa", dim = "#485e7d" },
  -- },
  -- nordfox = {
  --   -- A palette also defines the following:
  --   --   bg0, bg1, bg2, bg3, bg4, fg0, fg1, fg2, fg3, sel0, sel1, comment
  --   --
  --   -- These are the different foreground and background shades used by the theme.
  --   -- The base bg and fg is 1, 0 is normally the dark alternative. The others are
  --   -- incrementally lighter versions.
  --   bg1 = "#2e3440",
  --
  --   -- sel is different types of selection colors.
  --   sel0 = "#3e4a5b", -- Popup bg, visual selection bg
  --   sel1 = "#4f6074", -- Popup sel bg, search bg
  --
  --   -- comment is the definition of the comment color.
  --   comment = "#60728a",
  -- },

  -- Customization starts below
  --------------------------------------
  -- We will use "carbonfox" as our monochrome variant
  carbonfox = {
      -- These are from your terminal configs
      black   = base.black,
      red     = base.red,
      green   = base.green,
      yellow  = base.yellow,
      blue    = base.blue,
      magenta = base.magenta,
      cyan    = base.cyan,
      white   = base.white,
      orange  = base.orange,
      pink    = base.pink,

      bg0 = base.bgc:to_css(),
      bg1 = base.bgc:to_css(),
      bg2 = base.bgc:brighten(5):to_css(),
      bg3 = base.bgc:brighten(15):to_css(),
      bg4 = base.bgc:brighten(30):to_css(),

      fg0 = base.fgc:brighten(10):to_css(),
      fg1 = base.fgc:to_css(),
      fg2 = base.fgc:brighten(-25):to_css(),
      fg3 = base.fgc:brighten(-50):to_css(),

      sel0 = base.selc:to_css(),
      sel1 = base.selc:brighten(-6):to_css(),

      comment = base.fgc:brighten(-40):to_css(),
  },
}

-- Spec's (specifications) are a mapping of palettes to logical groups that will be
-- used by the groups. Some examples of the groups that specs map would be:
--   - syntax groups (functions, types, keywords, ...)
--   - diagnostic groups (error, warning, info, hints)
--   - git groups (add, removed, changed)
--
-- You can override these just like palettes
local specs = {
  carbonfox = {
    syntax = {
      bracket     = "fg1",              -- Brackets and Punctuation
      builtin0    = "fg1",              -- Builtin variable
      builtin1    = "fg1",              -- Builtin type
      builtin2    = "fg1",              -- Builtin const
      builtin3    = "fg1",              -- Not used
      comment     = "comment",          -- Comment
      conditional = "fg2",              -- Conditional and loop
      const       = "fg1",              -- Constants, imports and booleans
      dep         = "fg1",              -- Deprecated
      field       = "fg1",              -- Field
      func        = "fg1",              -- Functions and Titles
      ident       = "fg1",              -- Identifiers
      keyword     = "fg2",              -- Keywords
      number      = "fg1",              -- Numbers
      operator    = "fg1",              -- Operators
      preproc     = "fg2",              -- PreProc
      regex       = "fg2",              -- Regex
      statement   = "fg1",              -- Statements
      string      = "fg2",              -- Strings
      type        = "fg1",              -- Types
      variable    = "fg1",              -- Variables
    },

    diag = {
      error = "red",
      warn  = "yellow",
      info  = "blue",
      hint  = "yellow",
      ok    = "green",
    },

    diff = {
      add    = base.bgc:blend(C(base.green.bright), 0.2):to_css(),
      delete = base.bgc:blend(C(base.red.bright), 0.2):to_css(),
      change = base.bgc:blend(C(base.orange.bright), 0.2):to_css(),
      text   = base.bgc:blend(C(base.yellow.base), 0.4):to_css(),
    }
  }
}

-- Groups are the highlight group definitions. The keys of this table are the name of the highlight
-- groups that will be overridden. The value is a table with the following values:
--   - fg, bg, style, sp, link,
--
-- Just like `spec` groups support templates. This time the template is based on a spec object.
local groups = {

  -- Copied from github.com/EdenEast/nightfox.nvim/blob/44154e15/lua/nightfox/group/editor.lua
  carbonfox = {
    -- ColorColumn     = { bg = spec.bg2 }, -- used for the columns set with 'colorcolumn'
    -- Conceal         = { fg = spec.bg4 }, -- placeholder characters substituted for concealed text (see 'conceallevel')
    -- Cursor          = { fg = spec.bg1, bg = spec.fg1 }, -- character under the cursor
    -- lCursor         = { link = "Cursor" }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
    -- CursorIM        = { link = "Cursor" }, -- like Cursor, but used when in IME mode |CursorIM|
    -- CursorColumn    = { link = "CursorLine" }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine      = { bg = "bg2" }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
    -- Directory       = { fg = spec.syntax.func }, -- directory names (and other special names in listings)
    DiffAdd         = { fg = "fg0", bg = "diff.add" }, -- diff mode: Added line |diff.txt|
    DiffChange      = { fg = "fg0", bg = "diff.change" }, -- diff mode: Changed line |diff.txt|
    DiffDelete      = { fg = "fg0", bg = "diff.delete" }, -- diff mode: Deleted line |diff.txt|
    DiffText        = { fg = "fg0", bg = "diff.text" }, -- diff mode: Changed text within a changed line |diff.txt|
    -- EndOfBuffer     = { fg = spec.bg1 }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
    -- TermCursor      = {}, -- cursor in a focused terminal
    -- TermCursorNC    = {}, -- cursor in an unfocused terminal
    -- ErrorMsg        = { fg = spec.diag.error }, -- error messages on the command line
    WinSeparator    = { fg = "fg3" }, -- the column separating vertically split windows
    VertSplit       = { link = "WinSeparator" }, -- the column separating vertically split windows
    -- Folded          = { fg = spec.fg3, bg = spec.bg2 }, -- line used for closed folds
    -- FoldColumn      = { fg = spec.fg3 }, -- 'foldcolumn'
    -- SignColumn      = { fg = spec.fg3 }, -- column where |signs| are displayed
    -- SignColumnSB    = { link = "SignColumn" }, -- column where |signs| are displayed
    Substitute      = { link = "Search" }, -- |:substitute| replacement text highlighting
    LineNr          = { fg = "bg3" }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    CursorLineNr    = { bg = "bg2", fg = "fg2" }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    MatchParen      = { fg = "diag.info", style = "bold" }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    -- ModeMsg         = { fg = "fg1", style = "bold" }, -- 'showmode' message (e.g., "-- INSERT -- ")
    -- -- NOTE: This was commented out as there is an issue with setting this highlight group see issue #98
    -- -- MsgArea         = { fg = spec.fg2 }, -- Area for messages and cmdline
    -- -- MsgSeparator    = {}, -- Separator for scrolled messages, `msgsep` flag of 'display'
    -- MoreMsg         = { fg = spec.diag.info, style = "bold" }, -- |more-prompt|
    -- NonText         = { fg = spec.bg4 }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    -- Normal          = { fg = spec.fg1, bg = trans and "NONE" or spec.bg1 }, -- normal text
    -- NormalNC        = { fg = spec.fg1, bg = (inactive and spec.bg0) or (trans and "NONE") or spec.bg1 }, -- normal text in non-current windows
    NormalFloat     = { fg = "fg1", bg = "bg3" }, -- Normal text in floating windows.
    FloatBorder     = { fg = "fg3" }, -- war
    Pmenu           = { fg = "bg0", bg = "sel0" }, -- Popup menu: normal item.
    PmenuSel        = { fg = "bg0", bg = "sel1" }, -- Popup menu: selected item.
    PmenuSbar       = { link = "Pmenu" }, -- Popup menu: scrollbar.
    -- PmenuThumb      = { bg = spec.sel1 }, -- Popup menu: Thumb of the scrollbar.
    -- Question        = { link = "MoreMsg" }, -- |hit-enter| prompt and yes/no questions
    -- QuickFixLine    = { link = "CursorLine" }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    Search          = { fg = "bg1", bg = "sel1" }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
    IncSearch       = { fg = "bg1", bg = "diag.info" }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    -- CurSearch       = { link = "IncSearch"}, -- Search result under cursor (available since neovim >0.7.0 (https://github.com/neovim/neovim/commit/b16afe4d556af7c3e86b311cfffd1c68a5eed71f)).
    -- SpecialKey      = { link = "NonText" }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
    -- SpellBad        = { sp = spec.diag.error, style = "undercurl" }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    -- SpellCap        = { sp = spec.diag.warn, style = "undercurl" }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    -- SpellLocal      = { sp = spec.diag.info, style = "undercurl" }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    -- SpellRare       = { sp = spec.diag.info, style = "undercurl" }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
    -- StatusLine      = { fg = spec.fg2, bg = spec.bg0 }, -- status line of current window
    -- StatusLineNC    = { fg = spec.fg3, bg = spec.bg0 }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    --
    -- TabLine         = { fg = spec.fg2, bg = spec.bg2 }, -- tab pages line, not active tab page label
    -- TabLineFill     = { bg = spec.bg0 }, -- tab pages line, where there are no labels
    -- TabLineSel      = { fg = spec.bg1, bg = spec.fg3 }, -- tab pages line, active tab page label
    -- Title           = { fg = spec.syntax.func, style = "bold" }, -- titles for output from ":set all", ":autocmd" etc.
    Visual          = { fg = "bg0", bg = "sel0" }, -- Visual mode selection
    -- VisualNOS       = inv.visual and { style = "reverse" } or { link = "visual" }, -- Visual mode selection when vim is "Not Owning the Selection".
    -- WarningMsg      = { fg = spec.diag.warn }, -- warning messages
    -- Whitespace      = { fg = spec.bg3 }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    -- WildMenu        = { link = "Pmenu" }, -- current match in 'wildmenu' completion
    -- WinBar          = { fg = spec.fg3, bg = trans and "NONE" or spec.bg1, style = "bold" }, -- Window bar of current window.
    -- WinBarNC        = { fg = spec.fg3, bg = trans and "NONE" or inactive and spec.bg0 or spec.bg1, style = "bold" }, --Window bar of not-current windows.
  }
}

require("nightfox").setup({ palettes = palettes, specs = specs, groups = groups })
