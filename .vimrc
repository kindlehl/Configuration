"VUNDLE SHIT"

set nocompatible
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'auto-pairs'
Plugin 'tomtom/tcomment_vim', {'rtp': '~/.vim/bundle/tcomment_vim/plugin'}

call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"PLUGIN SETTINGS
"
"
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 3
"
"
"END PLUGIN SETTINGS
set exrc
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab
set number
highlight ColorColumn ctermbg=255,255,255
let &path.="/usr/include/AL,"
syntax on
set hidden
set wildmenu
set showcmd
set hlsearch
set ignorecase
set smartcase
set backspace=indent,eol,start
set autoindent
set nostartofline
set visualbell
set cmdheight=2
set notimeout ttimeout ttimeoutlen=200
set pastetoggle=<F11>
map Y y$
set mouse=""f

let g:ycm_autoclose_preview_window_after_insertion = 1

let mapleader = ","

nnoremap <leader>ev :edit ~/.vimrc<Enter>
nnoremap <leader>sv :source ~/.vimrc<Enter>
nnoremap <leader><leader>h <C-w>h
nnoremap <leader><leader>j <C-w>J
nnoremap <leader><leader>k <C-w>k
nnoremap <leader><leader>l <C-w>l
