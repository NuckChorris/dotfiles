" Vundle
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" Autoindent
set autoindent
filetype plugin indent on
set tabstop=3

" Syntax highlighting
syntax on
colorscheme monokai
set tabstop=3
