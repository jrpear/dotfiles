mkdir %userprofile%\vimfiles\after\ftplugin
mklink %userprofile%\vimfiles\vimrc %userprofile%\dotfiles\vimrc
mklink %userprofile%\vimfiles\vimrc.plugins %userprofile%\dotfiles\vimrc.plugins
mklink %userprofile%\vimfiles\after\ftplugin\tex.vim %userprofile%\dotfiles\vim\ftplugin\tex.vim
mkdir %userprofile%\AppData\Local\nvim
mklink %userprofile%\AppData\Local\nvim\init.vim %userprofile%\dotfiles\config\nvim\init.vim
