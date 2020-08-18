if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdcommenter'

call plug#end()

map <C-_> \c<Space>

set path=.**,,
syntax enable
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent
