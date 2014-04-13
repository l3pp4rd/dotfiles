#!/usr/bin/env zsh

# Enable more syntax highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# CDPATH tells the cd command to look in
# this colon-separated list of directories for your destination.
CDPATH=$HOME:..:/etc

# z - for fast ranked directory accesses
. $DOTFILES/z/z.sh

# Disable flow control in rxvt, frees ctrl-s & ctrl-q mappings
stty -ixon -ixoff

# Add dircolors
eval $(dircolors $DOTFILES/zsh/dircolors-solarized/dircolors.ansi-dark)

# default text editor
export EDITOR=vim

# checks if binary exists in path
has_bin() {
    TMP=`which $1 2> /dev/null`
    [ $? -eq 0 ]
}
