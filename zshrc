#!/usr/bin/env zsh

# This is my main zsh configuration.
# It loads scripts from zsh/ and oh-my-zsh/

# Path to your oh-my-zsh configuration.
DOTFILES=$HOME/.dotfiles
OHMYZSH=$DOTFILES/oh-my-zsh

# Load all of the config files in oh-my-zsh that end in .zsh
for config_file ($OHMYZSH/lib/*.zsh) source $config_file

# Load all of my zsh files in zsh/
for zsh_file ($DOTFILES/zsh/*.zsh) source $zsh_file

# Enable completion {
    autoload -U compinit
    compinit -i
# }

# plugins {
    # from oh-my-zsh {
        source $OHMYZSH/plugins/archlinux/archlinux.plugin.zsh
    # }
    # from other vendors {
        # Add fish-like syntax highlighting (must be done before substring search!)
        source $DOTFILES/zsh/syntax-highlighting/zsh-syntax-highlighting.zsh
        # Add history substring search
        source $DOTFILES/zsh/history-substring-search/zsh-history-substring-search.zsh
    # }
# }

# Theme {
    source "$OHMYZSH/themes/gentoo.zsh-theme"
# }

# launch x when booted
[[ $(tty) == /dev/tty1 ]] && startx

