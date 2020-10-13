rem Core Vim

mkdir %userprofile%\vimfiles
mklink \D %userprofile%\vimfiles\after %userprofile%\dotfiles\vim\after
mklink \D %userprofile%\vimfiles\plugin %userprofile%\dotfiles\vim\plugin
mklink %userprofile%\vimfiles\vimrc %userprofile%\dotfiles\vimrc
mklink %userprofile%\vimfiles\vimrc.plugins %userprofile%\dotfiles\vimrc.plugins

rem Neovim

mkdir %userprofile%\AppData\Local\nvim
mklink %userprofile%\AppData\Local\nvim\init.vim %userprofile%\dotfiles\config\nvim\init.vim

rem Octave

mklink %userprofile%\.octaverc %userprofile%\dotfiles\octaverc
