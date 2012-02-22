#!/bin/sh

# vim
VIMDIR=$HOME/.dotfiles/vim
rm ~/.vim
ln -s $VIMDIR ~/.vim
rm ~/.vimrc
ln -s $VIMDIR/vimrc ~/.vimrc

# git
GITDIR=$HOME/.dotfiles/git
rm ~/.gitconfig
ln -s $GITDIR/gitconfig ~/.gitconfig
rm ~/.gitignore
ln -s $GITDIR/gitignore ~/.gitignore

# zsh
rm ~/.zshrc
ln -s $HOME/.dotfiles/zshrc ~/.zshrc

