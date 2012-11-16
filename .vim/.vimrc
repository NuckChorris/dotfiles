set nocompatible

" ----------------------------------------------------------------------------
"  Text Formatting
" ----------------------------------------------------------------------------

set autoindent
filetype plugin indent on
set tabstop=3
set shiftwidth=3


" ----------------------------------------------------------------------------
"  Remapping
" ----------------------------------------------------------------------------

" exit to normal mode with 'jj'
inoremap jj <ESC>

" sane movement with wrap turned on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" ----------------------------------------------------------------------------
"  UI
" ----------------------------------------------------------------------------

set ruler
set number
set scrolloff=3
set laststatus=2
set showmatch
set mat=5

" Syntax Highlighting
syntax on
colorscheme monokai

" Mouse Selection
set selectmode+=mouse
set mouse=a

