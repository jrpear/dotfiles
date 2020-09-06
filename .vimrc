let mapleader=","

syntax enable

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

" Core tools
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'preservim/nerdtree'
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Small language-specific tools
Plug 'tpope/vim-ragtag'

" IDE-like, large, intrusive tools
Plug 'vim-vdebug/vdebug'
Plug 'vim-syntastic/syntastic'

" To try
" Plug 'ycm-core/YouCompleteMe'

call plug#end()

" For syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" For WSL
command Cp silent w !clip.exe

" For vdebug
command Pdb silent !python $PYTHONDBGPPATH -S -d localhost:9000 %:p &
command -nargs=? -bang Ve python3 debugger.handle_eval('<bang>', <q-args>)

