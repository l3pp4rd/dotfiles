## About

My .dotfiles for vim git and zsh

## Requirements

- You will need VIM >= **7.0** with a support of **ruby** interpreter
- **git** on your system
- **zsh** is optional

## Installation

Clone the repository:

    clone git://github.com/l3pp4rd/dotfiles.git ~/.dotfiles

If you do not use **zsh** ignore the .zshrc installation, otherwise you could try to use it instead
of bash - install **zsh** first and use it as your default shell by running:

    chsh -s $(which zsh)

Execute the setup script:

    ./.dotfiles/setup.sh

**NOTE:** it must be cloned as **~/.dotfiles**

Install submodules

    cd ~/.dotfiles && git submodule update --init

After that, for [command-t](http://github.com/wincent/Command-T) bundle you will need
to compile a **C** extension.

    cd ~/.vim/bundle/command-t
    ruby extconf.rb
    make

