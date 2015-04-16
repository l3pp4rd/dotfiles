# About my dotfiles

My .dotfiles **ViM, DWM, zsh, st** and I use **ArchLinux** as my linux distribution
Mainly inspired by [ornicar](https://github.com/ornicar/dotfiles). For all my programs and shell I use [solarized
colors](http://ethanschoonover.com/solarized) and mainly **Inconsolata** font.

## Requirements

- Recent **ViM** version, does not require any interpreters like ruby or python.
- **git**
- **zsh**
- **wget**
- **256** color terminal client for the best experience

To use tmuxinator:

    gem install tmuxinator

To install dmenu:

    git clone https://github.com/l3pp4rd/dmenu.git ~/.dmenu && cd ~/.dmenu

You most probably need to change the **X11** lib header file location if you are not using arch linux:

    vim config.mk
    make
    sudo make install # will install it in /usr/local/bin

Dmenu shortcut to list all path executables is available at **~/.dotfiles/bin/dmenu_run**
It will cache all recently used applications, that way it will show up first in search results.

## Screen

![Screenshot](https://raw.github.com/l3pp4rd/dotfiles/master/screen.png)

## Installation

Clone the repository:

    clone git://github.com/l3pp4rd/dotfiles.git ~/.dotfiles

### Terminal client

If you want nice colors with **vim** you should have a terminal client, which supports **256** colors. You may try:

- **st** the simplest and most stable terminal client, supports all general features. You can just grab my version of
[st](https://github.com/l3pp4rd/st) and compile it. If you need transparency, use **xcompmgr**.
- **rxvt-unicode** you may need to compile it with **256** color support, but it may come with all features from package
manager.
- some others **terminator**, **guake** whatever you like.

### Tmux

You should consider reading about **tmux** (terminal session manager) and install it. **Tmuxinator** is also a
handy tool to be used with tmux. If you use **st** tmux will provide tabs and history scrolling support.
Mouse scroll in urxvt suck and most of the times, tabs and history scrolling are not working well as general
terminal features. So lets just follow UNIX philosophy and install tmux which is a tool built to handle it.

### Zsh

If you do not use **zsh** ignore the .zshrc installation, otherwise you could try to use it instead
of bash - install **zsh** first and use it as your default shell by running:

    chsh -s $(which zsh)

### ViM

A **python** and **X** support may be useful in most cases to have with vim. **X** support will allow to copy and paste
from the same buffer and with python come some useful plugins. Anyway it is not necessary to compile vim on your own to
setup these dotfiles, but if you do:

```
hg clone https://vim.googlecode.com/hg/ /tmp/vim-build
cd /tmp/vim-build

./configure \
--prefix=/usr/local \
--with-features=huge \
--with-compiledby='Custom edition' \
--enable-gpm \
--enable-acl \
--with-x=yes \
--disable-gui \
--enable-multibyte \
--enable-cscope \
--disable-netbeans \
--enable-pythoninterp \
--disable-python3interp

make
sudo make install
```

### Install dotfiles

**NOTE:** analyze **Makefile** before you execute, it will force symlinks make sure to update for your needs..

    make

To update **git modules**, **fonts** and **vim** plugins:

    make update

**NOTE:** most configurations use **Inconsolata** fonts, you should install or change it.

## Window Manager

If you are tired of bloated desktops like gnome, kde.. whatever, would recommend to try [dwm](http://dwm.suckless.org/)

**NOTE:** look how to manage it as an xsession in order to provide a possibility to be used inline
with a login manager like **slim**.

## Changelog

- **2015-04-16** - Makefile for setup and updates
- **2014-05-31** - **ViM** does not depend on any interpreters. Restructured files
- **2014-04-13** - refactored zsh configuration, to reuse core oh-my-zsh loading features
- **2013-12-20** - switched from pathogen to vundle
- **2013-12-20** - switched powerline to airline, does not require big python setup

