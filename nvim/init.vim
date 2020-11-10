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

" noswapfile
set noswapfile
set nobackup
set noundofile

" keymap
let mapleader = "\<Space>"
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

" tabline
set showtabline=2

" vim-plug
call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <CR> <Plug>(coc-definition)
nmap <silent> <Leader>r <Plug>(coc-references)
nmap <silent> f <Plug>(coc-fix-current)

Plug 'jonathanfilip/vim-lucius'

Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
map <C-e> :NERDTreeTabsToggle<CR>
" ファイル指定せずにvimを開いた時にNERDTreeを最初から表示
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" NERDTreeToggleのウィンドウだけが残る場合はvimを終了
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 隠しファイル表示
let NERDTreeShowHidden = 1

Plug 'ryanoasis/vim-devicons'

Plug 'itchyny/lightline.vim'

Plug 'w0rp/ale'

Plug 'vim-jp/vimdoc-ja'

Plug 'mattn/vim-goimports'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
let g:fzf_layout = { 'down': '50%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
nnoremap <silent> <Leader>g :Rg<CR>
nnoremap <Leader>p :Files<CR>

call plug#end()


colorscheme lucius
