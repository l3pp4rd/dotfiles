#!/usr/bin/env zsh

# Enable more syntax highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# CDPATH tells the cd command to look in
# this colon-separated list of directories for your destination.
CDPATH=$HOME:..:/etc

# Add dircolors
eval $(dircolors $DOTFILES/zsh/dircolors-solarized/dircolors.ansi-dark)

# hub
has_bin "hub" && eval "$(hub alias -s)"

# git templates
export GIT_TEMPLATE_DIR=$DOTFILES/git/template

# default text editor
export EDITOR=vim

# default browser
export BROWSER=chromium
