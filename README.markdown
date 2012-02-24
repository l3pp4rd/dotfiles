## About

My .dotfiles for vim git and zsh

## Requirements

- You will need VIM >= **7.0** with a support of **ruby** interpreter

## Installation

Clone the repository:

    $ clone git://github.com/l3pp4rd/dotfiles.git ~/.dotfiles

**NOTE:** the setup.sh will remove your current, **.zshrc**, **.vimrc**, **.gitconfig** files
Execute the setup script:

    $ ./.dotfiles/setup.sh

After that, for [command-t](http://github.com/wincent/Command-T) bundle you will need
to compile a **C** extension.

    cd ~/.vim/bundle/command-t
    ruby extconf.rb
    make

