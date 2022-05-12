-- Load impatient for it to reduce startup time. Must be called
-- before all Lua plugins are loaded.
require "impatient"

-- Shorthands to accessors
local set  = vim.opt
local g    = vim.g
local map  = vim.keymap.set

-- Use Neovim's new Lua-based filetype detection
g.do_filetype_lua = 1
g.did_load_filetypes = 0

-- Leader/local leader
g.mapleader = [[;]]
g.maplocalleader = [[;]]

-- Disable some built-in plugins we don't want
local built_in_to_disable = {
    "gzip",
    "man",
    "matchit",
    "matchparen",
    "shada_plugin",
    "tarPlugin",
    "tar",
    "zipPlugin",
    "zip",
    "netrwPlugin",
}
for i = 1, 10 do
    g["loaded_" .. built_in_to_disable[i]] = 1
end

--------- Options ---------
-- File Control
set.autoread = true
set.autowrite = true

local file_control_augroup_id = vim.api.nvim_create_augroup(
    "file_control_augroup",
    { clear = true }
)
vim.api.nvim_create_autocmd(
    "vimresized",
    {
        group   = file_control_augroup_id,
        pattern = "*",
        command = "exe 'normal! <c-w>='",
    }
)  -- Automatically resize panes on resize
vim.api.nvim_create_autocmd(
    "focuslost",
    {
        group   = file_control_augroup_id,
        pattern = "*",
        command = "silent! wa",
    }
)  -- Save all files on loss of focus, ignoring warnings about untitled buffers

-- Tab Control
set.smarttab     = false      -- Don't mix spaces and tabs
set.tabstop      = 4          -- The visible width of tabs
set.softtabstop  = 4          -- Edit as if the tabs are 4 characters wide
set.shiftwidth   = 4          -- Number of spaces to use for indent and unindent
set.shiftround   = true       -- Round indent to a multiple of 'shiftwidth'
set.expandtab    = true       -- Use spaces in place of tabs anywhere, including pressing <TAB>

-- Text Control
set.smartindent  = true       -- Do smart autoindenting when starting a new line.

-- Search
set.ignorecase   = true       -- Case insensitive searching
set.smartcase    = true       -- Case-sensitive if expresson contains a capital letter
set.hlsearch     = true       -- Highlight search results
set.incsearch    = true       -- Set incremental search, like modern browsers

-- General
-- VIM command completion. Complete longest match, then show list of possible choices.
set.wildmode     = "longest,list"
set.shada        = "'30,<50,s20,h"   -- Enable and config "shared data" files
set.updatetime   = 500               -- Idle time before swap file is written to disk
set.undofile     = true              -- Save undo history
set.mouse        = "a"               -- Enable mouse support
-- set.clipboard   += "unnamedplus"  -- Yank to system clipboard

-- Syntax
set.number       = true       -- Show line number
set.showmatch    = true       -- Show matching braces
set.list         = true       -- Show invisible characters by default
set.listchars    = "tab:→ ,eol:¬,trail:⋅,extends:❯,precedes:❮"  -- Show invisible charactes as
set.showbreak    = "↪"        -- Show newlines as

-- Visuals
set.showmode        = false         -- Do not show "-- INSERT --", etc, on the last line.
set.scrolloff       = 5             -- 5-line buffer around the cursor when scrolling
set.termguicolors   = true          -- Enable 24-bit color
set.background      = "dark"        -- Set to dark 
vim.cmd "colorscheme lights-off"    -- Switch to theme


--------- Providers ---------
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.python3_host_prog = "/home/ryan/.pyenv/shims/python3"

--------- Keybinds ---------
map("n", "<Leader>vl", "<Cmd>set list!<CR>")     -- Toggle showing invisible characters

-- Textmate style indentation
map("v", "<Tab><Tab>", ">gv")
map("v", "<S-Tab>", "<gv")
map("n", "<Tab><Tab>", ">>")
map("n", "<S-Tab>", "<<")

-- Resize splits faster
map("n", "<Leader>s", "<Cmd>vertical resize +5<CR>")
map("n", "<Leader>a", "<Cmd>vertical resize -5<CR>")

-- Better pane navigation
map("n", "<C-J>", "<C-W>j")
map("n", "<C-K>", "<C-W>k")
map("n", "<C-H>", "<C-W>h")
map("n", "<C-L>", "<C-W>l")

-- Move faster
map({"n", "v"}, "<S-J>", "6j")
map({"n", "v"}, "<S-K>", "3k")

-- Join lines
map("n", "<leader>j", "<Cmd>join<CR>")
map("n", "<leader>J", "<Cmd>join!<CR>")

-- Toggle cursor line
map("n", "<Leader>i", "<Cmd>set cursorline!<CR>")

-- Disable search highlight
map("n", "<Space>", "<Cmd>noh<CR>")

-- Quick save and quit
map("n", "<Leader>w", "<Cmd>w<CR>")
map("n", "<Leader>q", "<Cmd>wq<CR>")

--------- Plugins ---------
require "plugins"

-- Load LSP configs
require "provider"
