mkdir %userprofile%\vimfiles
mklink %userprofile%\vimfiles\vimrc %userprofile%\dotfiles\vimrc
mklink %userprofile%\vimfiles\vimrc.plugins %userprofile%\dotfiles\vimrc.plugins
mkdir %userprofile%\AppData\Local\nvim
mklink %userprofile%\AppData\Local\nvim\init.vim %userprofile%\dotfiles\config\nvim\init.vim
