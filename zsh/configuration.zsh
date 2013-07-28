#!/usr/bin/env zsh

export SBT_OPTS="-Dfile.encoding=UTF8 -Xms512M -Xmx768M -Xss2M -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=512M"

# oh-my-zsh configuration
export DISABLE_AUTO_TITLE="true"

# skype 4.0 bugs
export GTK2_RC_FILES="/etc/gtk-2.0/gtkrc:$HOME/.gtkrc-2.0"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# Enable more syntax highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# CDPATH tells the cd command to look in
# this colon-separated list of directories for your destination.
CDPATH=$HOME:..:/etc

# Disable flow control in rxvt, frees ctrl-s & ctrl-q mappings
stty -ixon -ixoff

# Add dircolors
eval $(dircolors $DOTFILES/zsh/dircolors-solarized/dircolors.ansi-dark)

# default text editor
export EDITOR=vim

