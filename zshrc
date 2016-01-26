#!/usr/bin/env zsh

# This is my main zsh configuration.
# It loads scripts from zsh/ and oh-my-zsh/

# checks if binary exists in path
has_bin() {
    TMP=`which $1 2> /dev/null`
    [ $? -eq 0 ]
}

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
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# list of plugins
plugins=(
  golang                        # golang completions
  zsh-syntax-highlighting       # bracket highlighters
  zsh-history-substring-search  # history substring search
)

# source all oh-my-zsh libs, plugins, cust files
source $ZSH/oh-my-zsh.sh

# bind UP and DOWN arrow keys for history substring search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# tell me a fortune :)
has_bin "fortune" && has_bin "cowsay" && fortune -a /usr/share/fortune/chucknorris | cowsay

