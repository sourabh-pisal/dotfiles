" ============================================================
" General Settings 
" ============================================================

set number
set relativenumber

set mouse=

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

set smartindent
set wrap
set linebreak
set breakindent

set autoread

let mapleader = " "

set noswapfile
set nobackup
if !isdirectory($HOME . "/.vim/undodir")
  call mkdir($HOME . "/.vim/undodir", "p")
endif
set undodir=$HOME/.vim/undodir
set undofile

set nohlsearch
set incsearch

set scrolloff=8
set signcolumn=yes

set paste

set updatetime=50

" ============================================================
" Keymaps
" ============================================================

" Move lines up/down in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Keep cursor centered while jumping
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Keep cursor centered while searching
nnoremap n nzzzv
nnoremap N Nzzzv

" Scroll by 5 lines
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

" Yank/paste to system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p

" Delete into void register
nnoremap <leader>d "_d
vnoremap <leader>d "_d
