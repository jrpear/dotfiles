
set encoding=utf-8

set nocompatible
set showcmd

let mapleader=","

nnoremap <Leader><Leader> <C-^>

" For WSL
command Cp silent w !clip.exe

" Enable project-specific .vimrc
set exrc
set secure

if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax enable
endif

" These are the defaults, to be overwritten by vim-sleuth

set tabstop=4
set shiftwidth=4
set expandtab

if filereadable(expand("~/.vimrc.plugins"))
  source ~/.vimrc.plugins
endif

" set solarized light color scheme
set background=light
colorscheme solarized
let g:solarized_termtrans=1
