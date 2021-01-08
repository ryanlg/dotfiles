" Section General {{{

" Abbreviations
abbr funciton function
abbr teh the
abbr tempalte template
abbr fitler filter

set tags=tags

" let g:plug_url_format='git@Ryanget:%s.git'
source ~/.config/nvim/plugins.vim " Plugin manager

set nocompatible            " not compatible with vi
set autoread                " detect when a file is changed
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif " auto read after focus regain
set autowrite               " save on switching buffer

set history=1000            " change history to 1000

set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp


" }}}


" Section User Interface {{{
"
" Use 24-bit (true-color) mode
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" switch cursor to line when in insert mode, and block when not
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" always show status bar for powerline
set laststatus=2

syntax on
colorscheme lights-off        " Set the colorscheme
set background=dark
" let g:lightline = {
"       \ 'colorscheme': 'one',
"       \ }
" set guifont=Menlo\ for\ Powerline\ 20

" airline options
" let g:airline_powerline_fonts=1
let g:airline_theme='minimalist'
let g:airline_left_sep=''
let g:airline_right_sep=''
" let g:airline#extensions#tabline#enabled = 1 " enable airline tabline
" let g:airline#extensions#tabline#tab_min_count = 2 " only show tabline if tabs are being used (more than 1 tab open)
" let g:airline#extensions#tabline#show_buffers = 1 " show open buffers in tabline
" let g:airline#extensions#tabline#show_splits = 1

" let g:airline#extensions#bufferline#enabled = 1

"airline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" make the highlighting of tabs and other non-text less annoying
highlight SpecialKey ctermbg=none ctermfg=8
highlight NonText ctermbg=none ctermfg=8

" make comments and HTML attributes italic
highlight Comment cterm=italic
highlight htmlArg cterm=italic

set number                  " show line numbers

set wrap                    " turn on line wrapping
set wrapmargin=8            " wrap lines when coming within n characters from side
set linebreak               " set soft wrapping
set showbreak=…             " show ellipsis at breaking

filetype indent on
set autoindent              " automatically set indent of new line
set smartindent

" toggle invisible characters
set list
set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪

" highlight conflicts
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" make backspace behave in a sane manner
set backspace=indent,eol,start

" Tab control
" set smarttab                " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=4               " the visible width of tabs
set softtabstop=4           " edit as if the tabs are 4 characters wide
set shiftwidth=4            " number of spaces to use for indent and unindent
set shiftround              " round indent to a multiple of 'shiftwidth'
set completeopt+=longest
set expandtab

" code folding settings
set foldmethod=syntax       " fold based on indent
set foldnestmax=10          " deepest fold is 10 levels
set nofoldenable            " don't fold by default
set foldlevel=1

" set clipboard=unnamed

set ttyfast                 " faster redrawing
set diffopt+=vertical
set laststatus=2            " show the satus line all the time
set so=7                    " set 7 lines to the cursors - when moving vertical
set wildmenu                " enhanced command line completion
set hidden                  " current buffer can be put into background
set showcmd                 " show incomplete commands
set noshowmode              " don't show which mode disabled for PowerLine
set wildmode=list:longest   " complete files like a shell
set scrolloff=3             " lines of text around cursor
set shell=$SHELL
set cmdheight=1             " command bar height
set title                   " set terminal title

" Searching
set ignorecase              " case insensitive searching
set smartcase               " case-sensitive if expresson contains a capital letter
set hlsearch                " highlight search results
set incsearch               " set incremental search, like modern browsers
set nolazyredraw            " don't redraw while executing macros

set magic                   " Set magic on, for regex

set showmatch               " show matching braces
set mat=2                   " how many tenths of a second to blink

" error bells
set noerrorbells
set visualbell
set t_vb=
set tm=500

if has('mouse')
	set mouse=a
	" set ttymouse=xterm2
endif
" }}}

" Section Mappings {{{

" set a map leader for more key combos
let mapleader = ';'

" set paste toggle
set pastetoggle=<leader>v

" toggle paste mode
" map <leader>v :set paste!<cr>

" edit ~/.config/nvim/init.vim
map <leader>ev :e! ~/.config/nvim/init.vim<cr>

" clear highlighted search
nnoremap <space> <esc> :noh<cr><esc>

" activate spell-checking alternatives
nmap ;s :set invspell spelllang=en<cr>


" show white space
nmap <leader>l :set list!<cr>

" Textmate style indentation
" () because I switched my ( key with [
vmap <Tab><Tab> >gv
vmap <S-Tab> <gv
nmap <Tab><Tab> >>
nmap <S-Tab> <<

" Resizing splits

call submode#enter_with('grow/shrink', 'n', '', '<C-w>=', ':vertical resize +5<cr>')
call submode#enter_with('grow/shrink', 'n', '', '<C-w>_', ':vertical resize -5<cr>')
call submode#map('grow/shrink', 'n', '', '=', ':vertical resize +5<cr>')
call submode#map('grow/shrink', 'n', '', '_', ':vertical resize -5<cr>')

" Auto closing braces on newline
inoremap {<CR> {<CR>}<Esc>ko
inoremap [<CR> [<CR>]<Esc>ko
inoremap (<CR> (<CR>)<Esc>ko

" switch between current and last buffer
nmap <leader>. <c-^>

" enable . command in visual mode
vnoremap . :normal .<cr>

" better panel nav
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

" nav faster
nmap <S-J> 6j
vmap <S-J> 6j
nmap <S-K> 3k
vmap <S-K> 3k

" Since we use S-J for nav, we need something else for line join
nmap <leader>j :join<cr>
nmap <leader>J :join!<cr>

" toggle cursor line
nnoremap <leader>i :set cursorline!<cr>

" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> ^ g^
nnoremap <silent> $ g$

" search for word under the cursor
nnoremap <leader>\ "fyiw :/<c-r>f<cr>

" quicker save
nnoremap <C-S> :w<cr>
nnoremap <C-Q> :q<cr>

" Section Autogroups {{{
" file type specific settings
augroup configgroup
    autocmd!

    " automatically resize panes on resize
    autocmd vimresized * exe 'normal! \<c-w>='

	" auto source
    autocmd bufwritepost .vimrc,.vimrc.local,init.vim source %
    autocmd bufwritepost .vimrc.local source %

    " save all files on focus lost, ignoring warnings about untitled buffers
    autocmd focuslost * silent! wa
augroup END

" }}}


" Plugins
" Nerd Tree
let NERDTreeShowHidden=1 " show hidden files
let NERDTreeIgnore = ['\.DS_Store$', '__pycache__$', 'node_modules$']
map <silent> <C-\> :NERDTreeToggle<CR> " toggle
nmap <silent> <leader>f :NERDTreeFind<cr> " show current fild in tree

" fzf
nmap <silent> <C-p> :FZF<cr>

" Ag
nmap <silent> <C-f> :Ag<cr>

" NASM
let g:asmsyntax = 'nasm'

" YCM, no longer used, it's slow as hell
" let g:loaded_youcompleteme = 1 " Set to 1 to disabel YCM
" let g:ycm_python_binary_path = '/Users/ryan/.pyenv/shims/python'
" let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
" let g:ycm_autoclose_preview_window_after_insertion = 1
" let g:ycm_autoclose_preview_window_after_completion = 1

" CPP syntax highlight
" let g:cpp_class_scope_highlight = 1
" let g:cpp_concepts_highlight = 1
" let g:cpp_member_variable_highlight = 1
" let g:cpp_class_decl_highlight = 1

" ALE, no longer used
" let g:ale_linters = {
" \   'python': ['flake8'],
" \   'text': ['proselint'],
" \}
" let g:ale_lint_on_text_changed = 0
" let g:ale_lint_on_enter = 1
" let g:ale_lint_on_save = 1
