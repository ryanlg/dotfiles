" Specify a directory for plugins
call plug#begin('~/.config/nvim/plugged')

" =========== Theme ===========
" Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'
Plug 'vim-airline/vim-airline' " fancy statusline

" =========== General ===========
" Plug 'Shougo/echodoc.vim' " Displays function signatures from completions in the command line.
" Plug 'tpope/vim-obsession' " remember your sessions when restarting
" Plug 'airblade/vim-gitgutter'  " Changes in Git on the left
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] } | Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'ryanoasis/vim-devicons' " file drawer
" Plug 'jiangmiao/auto-pairs' " automatic closing of quotes, parenthesis, brackets, etc.
Plug 'tpope/vim-commentary' " comment stuff out
" Plug 'tpope/vim-surround' " mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.
" Plug 'benekastah/neomake' " neovim replacement for syntastic using neovim's job control functonality
" Plug 'tpope/vim-fugitive' " amazing git wrapper for vim
Plug 'tpope/vim-repeat' " enables repeating other supported plugins with the . command
" Plug 'garbas/vim-snipmate' | Plug 'MarcWeber/vim-addon-mw-utils' | Plug 'tomtom/tlib_vim' " provide support for textual snippets
" Plug 'AndrewRadev/splitjoin.vim' " single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one
" Plug 'sickill/vim-pasta' " context-aware pasting
" Plug 'junegunn/limelight.vim', { 'on': 'Limelight' } " focus tool. Good for presentating with vim
" Plug 'ctrlpvim/ctrlp.vim' " <C-B> Buffer fuzzy finder
Plug 'kana/vim-submode' " for sticky modifier keys, e.g. resizing window without pressing <C-W> everytime.
" Plug 'tmux-plugins/vim-tmux-focus-events' "FocusGained and FocusLost autocommand events are not working in terminal vim

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" ============== Language General =========
" Plug 'Valloric/YouCompleteMe' " YCM
" Plug 'w0rp/ale' "Asynchronous Lint Engine

" =============== Javascript ==============
Plug 'pangloss/vim-javascript' " JS syntax
" Plug 'nikvdp/ejs-syntax' " .ejs syntax

" =============== Python ================
" Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'vim-python/python-syntax'

" ================ Wechat ==============
" Plug 'chemzqm/wxapp.vim'


" Initialize plugin system
call plug#end()
