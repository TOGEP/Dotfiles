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
" wsl yank setting
if has("wsl")
   augroup Yank
        autocmd!
        autocmd TextYankPost * :call system('clip.exe ',@")
    augroup END
endif

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
noremap H ^
noremap L g_
" US keyboad
nnoremap ; :
nnoremap : ;
vnoremap : :
vnoremap : ;

" tabline
set showtabline=2

" undo
set undolevels=1000
if has('persistent_undo')
  let undo_path = expand('~/.vim/undo')
  if !isdirectory(undo_path)
    call mkdir(undo_path, 'p')
  endif
  set undofile
endif

" open&source vimrc
nnoremap <Leader>. :new ~/Dotfiles/nvim/init.vim<CR>
nnoremap <Leader>, :source ~/Dotfiles/nvim/init.vim<CR>

" vim-plug
call plug#begin(stdpath('data') . '/plugged')

" lsp
" masonは遅延読み込みが非推奨となっているのでプラグイン読み込みはinitファイル上で書くように
" > mason.nvim is optimized to load as little as possible during setup. Lazy-loading the plugin, or somehow deferring the setup, is not recommended.
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'nvim-lua/plenary.nvim'
Plug 'petertriho/cmp-git'
Plug 'hrsh7th/nvim-cmp'
" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
" TODO change from vsnip to luasnip.
" Plug 'L3MON4D3/LuaSnip'
" Plug 'saadparwaiz1/cmp_luasnip'
" For 'copilot.vim' users.
Plug 'hrsh7th/cmp-copilot'

lua << EOF
-- lsp settings
-- lspの設定に関しては遅延読み込みしても良い
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
-- Enable completion triggered by <c-x><c-o>
vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
local bufopts = { noremap=true, silent=true, buffer=bufnr }
-- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, bufopts)
vim.keymap.set('n', 'rn', vim.lsp.buf.rename, bufopts)
vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end
EOF

" colorscheme
Plug 'jonathanfilip/vim-lucius'
Plug 'ghifarit53/tokyonight-vim'
Plug 'EdenEast/nightfox.nvim'

Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
map <C-e> :NERDTreeTabsToggle<CR>
" ファイル指定せずにvimを開いた時にNERDTreeを最初から表示
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" NERDTreeToggleのウィンドウだけが残る場合はvimを終了
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 隠しファイル表示
let NERDTreeShowHidden = 1

Plug 'ryanoasis/vim-devicons'

Plug 'itchyny/lightline.vim'

Plug 'w0rp/ale'

Plug 'vim-jp/vimdoc-ja'

Plug 'mattn/vim-goimports'

" Plug 'airblade/vim-rooter'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
let g:fzf_layout = { 'down': '50%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \ 'rg --column --line-number --no-heading --hidden --smart-case --glob "!\.git/*" -- '.shellescape(<q-args>),
  \ 1,
  \ fzf#vim#with_preview({'dir': system('git rev-parse --show-toplevel 2> /dev/null')[:-2]}),
  \ <bang>0)
nnoremap <silent> <Leader>g :Rg<CR>
nnoremap <Leader>p :GFiles<CR>

Plug 'easymotion/vim-easymotion'
" Disable default mappings
let g:EasyMotion_do_mapping = 0
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1
" <Leader>f{char} to move to {char}
map <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
" <Leader>s{char}{char} to move to {char}{char}
nmap <Leader>s <Plug>(easymotion-overwin-f2)
vmap <Leader>s <Plug>(easymotion-bd-f2)
" Move to line
map <Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader>l <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

Plug 'airblade/vim-gitgutter'
set updatetime=250
" Move to Hunk
nmap [h <Plug>(GitGutterPrevHunk)
nmap ]h <Plug>(GitGutterNextHunk)
" Highlight Toggle
nnoremap <Leader>hh :GitGutterLineHighlightsToggle<CR>
" default gitgutter maps
" nmap <Leader>hs <Plug>GitGutterStageHunk
" nmap <Leader>hr <Plug>GitGutterRevertHunk
" nmap <Leader>hp <Plug>GitGutterPreviewHunk

Plug 'APZelos/blamer.nvim'

" not pre build build bundle for ARM platform.(2021/4/26)
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

Plug 'mattn/vim-maketable'

Plug 'jiangmiao/auto-pairs'

Plug 'mbbill/undotree'
nnoremap <F5> :UndotreeToggle<CR>

Plug 'lervag/vimtex'

Plug 'simeji/winresizer'
let g:winresizer_vert_resize = 1
let g:winresizer_horiz_resize = 1

Plug 'thinca/vim-quickrun', {'on': 'QuickRun'}
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
let g:quickrun_config = {
  \'_' : {
    \ 'outputter/error/success': 'buffer',
    \ 'outputter/error/error': 'quickfix',
    \ 'outputter/quickfix/open_cmd': 'copen',
    \ 'runner' : "vimproc",
    \ 'runner/vimproc/updatetime' : 60,
    \ 'hook/time/enable': 1
  \ },
\}

" 小文字rと大文字RでQuickRunの挙動を分岐
" 小文字rの場合:カレントディレクトリにinputファイルがあれば中身を標準入力として引き渡して実行，それ以外は標準入力無しで実行
" 大文字Rの場合:クリップボードの中身を標準入力として引き渡して実行
nnoremap <Leader>r :call <SID>DoQuickRun()<CR>
nnoremap <Leader>R :QuickRun -input =@+<CR>
function! s:DoQuickRun() abort
  if filereadable('input')
    execute ':QuickRun <input'
  else
    execute ':QuickRun'
  endif
endfunction

Plug 'liuchengxu/vim-which-key'
nnoremap <silent> <Leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <Leader> :<c-u>WhichKeyVisual '<Space>'<CR>
" By default timeoutlen is 1000 ms
set timeoutlen=500

Plug 'sebdah/vim-delve'
autocmd fileType go nnoremap <silent> gb :<c-u>DlvDebug<CR>
autocmd fileType go command! BP :DlvToggleBreakpoint
autocmd fileType go command! BPC :DlvClearAll

Plug 'github/copilot.vim'

Plug 'google/vim-jsonnet'

" 安定板が出たら使うかも
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

" lsp setup
lua << EOF
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {}
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    -- ["rust_analyzer"] = function ()
    --    require("rust-tools").setup {}
    -- end
}
EOF

" Setup language servers.
lua << EOF
local lspconfig = require('lspconfig')
lspconfig.gopls.setup {}
lspconfig.terraformls.setup {}
lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
}
EOF



" Set up nvim-cmp.
lua << EOF
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
 
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  cmp.setup {
    sources = {
      { name = 'copilot' }
    }
  }

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
  --   capabilities = capabilities
  -- }
EOF

colorscheme nightfox
