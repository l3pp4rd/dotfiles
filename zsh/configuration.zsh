#!/usr/bin/env zsh

export SBT_OPTS="-Dfile.encoding=UTF8 -Xms512M -Xmx768M -Xss2M -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=512M"

# oh-my-zsh configuration
export DISABLE_AUTO_TITLE="true"

# skype 4.0 bugs
export GTK2_RC_FILES="/etc/gtk-2.0/gtkrc:$HOME/.gtkrc-2.0"

# Enable more syntax highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# CDPATH tells the cd command to look in
# this colon-separated list of directories for your destination.
CDPATH=$HOME:..:/etc

# Disable flow control in rxvt, frees ctrl-s & ctrl-q mappings
stty -ixon -ixoff

# Add dircolors
eval $(dircolors $DOTFILES/zsh/dircolors-solarized/dircolors.ansi-dark)

# Remember ssh key authentication, check for availability first
NA=`which keychain | grep "not found" | wc -l`
if [ $NA -eq 1 ]; then
    eval `keychain --eval --agents ssh --nogui -Q -q id_rsa`
fi

export EDITOR=vim

