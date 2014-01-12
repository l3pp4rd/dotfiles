#!/usr/bin/env zsh

# This is my main zsh configuration.
# It loads scripts from zsh/ and oh-my-zsh/

# Path to your oh-my-zsh configuration.
DOTFILES=$HOME/.dotfiles
ZSH=$DOTFILES/oh-my-zsh

# helper method
has_executable() {
    TMP=`which $1 2> /dev/null`
    [ $? -eq 0 ]
}

# Load all of the config files in oh-my-zsh that end in .zsh
for config_file ($ZSH/lib/*.zsh) source $config_file

# Load all of my zsh files in zsh/
for zsh_file ($DOTFILES/zsh/*.zsh) source $zsh_file

fpath=($DOTFILES/zsh/autocompletions/src $fpath)

# Enable completion {
    autoload -U compinit
    compinit -i
# }

# Plugins {
    # main zsh repository
    plugins=(git extract go history-substring-search symfony2 systemd)
    for plugin in $plugins; do
        source $ZSH/plugins/$plugin/$plugin.plugin.zsh
    done
    # from other vendors {
        # Add fish-like syntax highlighting (must be done before substring search!)
        source $DOTFILES/zsh/syntax-highlighting/zsh-syntax-highlighting.zsh
        # bind UP and DOWN arrow keys
        for keycode in '[' '0'; do
          bindkey "^[${keycode}A" history-substring-search-up
          bindkey "^[${keycode}B" history-substring-search-down
        done
        unset keycode
    # }
# }

# Theme {
    source "$ZSH/themes/gentoo.zsh-theme"
# }

# tell me a fortune :)
has_executable "fortune" && has_executable "cowsay" && fortune | cowsay

