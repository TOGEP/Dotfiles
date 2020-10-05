" encode setting
set encoding=utf-8

" display
set number
set cursorline
set showmatch
set whichwrap=b,s,h,l,<,>,[,],~
set mouse=a
set termguicolors
set background=dark
syntax on


" Tab/Indent
set expandtab
set tabstop=2
set softtabstop=2
set autoindent
set smartindent
set shiftwidth=2

" clipboard
set clipboard=unnamed

" search
set incsearch
set ignorecase
set smartcase
set hlsearch

" complement
set wildmenu
set history=5000

" vim-plug
call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jonathanfilip/vim-lucius'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'fatih/vim-go'
Plug 'w0rp/ale'

call plug#end()


colorscheme lucius
