## About

My .dotfiles **ViM, DWM, zsh** and I use **ArchLinux** as my linux distribution
Mainly inspired by [ornicar](https://github.com/ornicar/dotfiles)

## Requirements

- You will need latest **ViM** with a support of **ruby** interpreter
- **git**
- **zsh**

## Screen

![Screenshot](https://raw.github.com/l3pp4rd/dotfiles/master/screen.png)

## Installation

If you are tired of bloated desktops like gnome, kde.. whatever, would recommend to try [dwm](http://dwm.suckless.org/)

Clone the repository:

    clone git://github.com/l3pp4rd/dotfiles.git ~/.dotfiles

If you do not use **zsh** ignore the .zshrc installation, otherwise you could try to use it instead
of bash - install **zsh** first and use it as your default shell by running:

    chsh -s $(which zsh)

**NOTE:** setup.sh will replace vim git configs in home directory
Execute the setup script:

    ./.dotfiles/setup.sh

Install submodules

    cd ~/.dotfiles && git submodule update --init

### Command-T

After that, for [command-t](http://github.com/wincent/Command-T) bundle you will need
to compile a **C** extension.

    cd ~/.vim/bundle/command-t/ruby/commant-t
    ruby extconf.rb
    make

### YouCompleteMe

For [awesome autocompletion](https://github.com/Valloric/YouCompleteMe) bundle you will need to compile **C++** ycm
package in order to get the match lookup fast.

For archlinux steps are simple:

    cd ~/.vim/bundle/you-complete-me/cpp
    cmake -G "Unix Makefiles" -DUSE_SYSTEM_LIBCLANG=ON
    make ycm_core
    rm compile_commands.json

You will need **cmake, clang** packages additionaly here. Otherwise read [installation
docs](http://valloric.github.com/YouCompleteMe/) carefully.

