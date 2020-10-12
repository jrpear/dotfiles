# Installation

First clone the repo. This must be done in your home folder for the
installation scripts to work.

    git clone git://github.com/jpear1/dotfiles.git

Next, copy or symlink files to their expected locations. For convenience,
install scripts are provided for Unix and Windows. 

Notes on the Windows script:

- On Windows, you have to have permission to create symlinks. This means
  that you must either have Developer Mode enabled or run the script as an
  administrator.
- Most of these programs are only useful for Unix-like OS's. The Windows
  script only installs the vim files.

Unix-like:

    ./install.sh

Windows:

    install.bat
