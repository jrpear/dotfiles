if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" These are the defaults, to be overwritten by vim-sleuth
set tabstop=4
set shiftwidth=4
set expandtab

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'godlygeek/tabular'
Plug 'vim-vdebug/vdebug'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'preservim/nerdtree'

call plug#end()

map <C-_> \c<Space>

set path=.**,,
syntax enable

