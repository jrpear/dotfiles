set encoding=utf-8

set nocompatible
set showcmd
syntax on

if has('nvim')
  set inccommand=nosplit
endif

let mapleader=" "

" For WSL
command Cp silent w !clip.exe

" Enable project-specific .vimrc
set exrc
set secure

" These are the defaults, to be overwritten by vim-sleuth
set tabstop=4
set shiftwidth=4
set expandtab

" Make it easier to exit terminal mode in nvim
if has('nvim')
  tnoremap <M-]> <C-\><C-n>
endif

" Window switching keybindings
" Insert mode:
inoremap <M-h> <EsC><C-w>h
inoremap <M-j> <EsC><C-w>j
inoremap <M-k> <EsC><C-w>k
inoremap <M-l> <EsC><C-w>l
" Visual mode:
vnoremap <M-h> <EsC><C-w>h
vnoremap <M-j> <EsC><C-w>j
vnoremap <M-k> <EsC><C-w>k
vnoremap <M-l> <EsC><C-w>l
" Normal mode:
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
if has('nvim')
  " Terminal mode:
  tnoremap <M-h> <C-\><C-n><C-w>h
  tnoremap <M-j> <C-\><C-n><C-w>j
  tnoremap <M-k> <C-\><C-n><C-w>k
  tnoremap <M-l> <C-\><C-n><C-w>l
endif

if has('win32')
  source ~\vimfiles\vimrc.plugins
else
  source ~/.vimrc.plugins
endif

" Override plugins to disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=r formatoptions-=o

" Enable comments in matlab
autocmd FileType matlab setlocal commentstring=\%\ %s

if !exists('g:vscode') && !has('win32')
  " Set solarized light color scheme
  set background=light
  colorscheme solarized
  let g:solarized_termtrans=1
endif
