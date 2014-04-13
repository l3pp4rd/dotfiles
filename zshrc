#!/usr/bin/env zsh

# This is my main zsh configuration.
# It loads scripts from zsh/ and oh-my-zsh/

# Dotfiles path
DOTFILES=$HOME/.dotfiles

# Main oh-my-zsh path
ZSH=$DOTFILES/oh-my-zsh

# theme
ZSH_THEME="gentoo"

# custom plugins and scripts
ZSH_CUSTOM=$DOTFILES/zsh

# some settings
DISABLE_AUTO_UPDATE="true"
DISABLE_AUTO_TITLE="true"

# additional autocompletions
fpath=($ZSH_CUSTOM/autocompletions/src $fpath)

# list of plugins
plugins=(
  git                           # git source control
  extract                       # archive extraction shortcut
  golang                        # golang completions
  zsh-syntax-highlighting       # bracket highlighters
  zsh-history-substring-search  # history substring search
  symfony2                      # symfony2 helpers
  systemd                       # systemd shortcuts
)

# source all oh-my-zsh libs, plugins, cust files
source $ZSH/oh-my-zsh.sh

# bind UP and DOWN arrow keys for history substring search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# tell me a fortune :)
has_bin "fortune" && has_bin "cowsay" && fortune | cowsay

