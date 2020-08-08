# About my dotfiles

My _.dotfiles_ for **ViM, DWM, zsh, alacritty** for linux based
distributions. For all my programs and shell, I mainly use [solarized
colors](http://ethanschoonover.com/solarized) and **Inconsolata** font.

## Requirements

- **ViM** decent version, does not require any interpreters like **ruby**
  or **python**. Run **make vim** to compile with python2 support. When
  python is available **YouCompleteMe** autocompletion plugin will be
  plugged, otherwise supertab, which is less powerful.
- **git** to manage modules and install vim
- **zsh** if used as a default shell client
- **wget** to download fonts
- **256** color terminal client for the best experience, consider [st](http://st.suckless.org/)
or [urxvt](https://wiki.gentoo.org/wiki/Rxvt-unicode)

To install **dmenu** as application launcher:

    git clone https://github.com/l3pp4rd/dmenu.git ~/.dmenu && cd ~/.dmenu

You most probably need to change the **X11** lib header file location if
you are not using arch linux:

    vim config.mk
    make
    sudo make install # will install it in /usr/local/bin

## tmuxstart

To prevent ruby dependencies, I manage my **tmux** sessions with
[tmuxstart](https://github.com/treyhunner/tmuxstart). Before that I was
using **tmuxinator**. One session example is
**~/.dotfiles/tmuxstart/dotfiles**. There is a **dmenu** executable to
run **workspace** switch.

## Screen

![Screenshot](https://cloud.githubusercontent.com/assets/132389/11821998/fde7b18c-a374-11e5-9c56-102ac54c70ae.png)

## Installation

Clone the repository:

    clone git://github.com/l3pp4rd/dotfiles.git ~/.dotfiles

### Tmux

You should consider reading about **tmux** (terminal session manager) and
install it. **tmuxstart** is also a handy tool to be used with tmux. If
you use **st** tmux will provide tabs and history scrolling support. Mouse
scroll in urxvt suck and most of the times, tabs and history scrolling
are not working well as general terminal features. So lets just follow
UNIX philosophy and install tmux which is a tool built to handle it.

### Zsh

If you do not use **zsh** ignore the .zshrc installation, otherwise you
could try to use it instead of bash - install **zsh** first and use it as
your default shell by running:

    chsh -s $(which zsh)

### ViM

A **python** and **X** support may be useful in most cases to have with
vim. **X** support will allow to copy and paste from the same buffer and
with python come some useful plugins. Anyway it is not necessary to
compile vim on your own to setup these dotfiles, usually **python** is
builtin, but if you do:

    make vim

### Install dotfiles

**WARNING:** analyze **Makefile** before you execute it, this will force
symlinks for various dotfiles like **gitconfig**. Make sure to update for
your needs..

    make

To update **git modules**, **fonts** and **vim** plugins from time to
time:

    make update

**NOTE:** most configurations use **Inconsolata** fonts, you should
install or change it.

## Status bar

This fancy statusbar has now [separate
repository](https://github.com/l3pp4rd/statusbar). You can choose
something else based on your preference or windows manager.

## Window Manager

If you are tired of bloated desktops like gnome, kde.. whatever, would
recommend to try [dwm](http://dwm.suckless.org/)

**NOTE:** look how to manage it as an xsession in order to provide
a possibility to be used inline with a login manager like **slim**.

## Changelog

- **2020-08-08** - removed syntastic, add
  [alacritty](https://github.com/alacritty/alacritty) config, fixes python
  dependency in vimrc
- **2016-07-11** - plugins and modules were updated, was not compatible
  anymore with the **upstream**.
- **2015-12-15** - **Makefile** has update or install command.
- **2015-05-24** - switched tmuxinator to tmuxstart, does not require ruby
- **2015-05-10** - switched vim plugin manager to [vim-plug](https://github.com/junegunn/vim-plug)
- **2015-04-16** - Makefile for setup and updates
- **2014-05-31** - **ViM** does not depend on any interpreters. Restructured files
- **2014-04-13** - refactored zsh configuration, to reuse core oh-my-zsh loading features
- **2013-12-20** - switched from pathogen to vundle
- **2013-12-20** - switched powerline to airline, does not require big python setup

