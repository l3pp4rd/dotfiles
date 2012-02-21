#!/bin/sh

BASEDIR=$(dirname $0)

# vim
VIMDIR=$BASEDIR/vim
rm ~/.vim
ln -s $VIMDIR ~/.vim
rm ~/.vimrc
ln -s $VIMDIR/vimrc ~/.vimrc

# git
GITDIR=$BASEDIR/git
rm ~/.gitconfig
ln -s $GITDIR/gitconfig ~/.gitconfig
rm ~/.gitignore
ln -s $GITDIR/gitignore ~/.gitignore

# zsh
ZSHDIR=$BASEDIR/zsh
rm ~/.zshrc
ln -s $ZSHDIR/zshrc ~/.zshrc
