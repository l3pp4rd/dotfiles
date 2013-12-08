#!/usr/bin/env zsh

# making sure all system bin dirs are exported
export PATH=$PATH:/usr/local/bin:/usr/bin

# bin dir at home
if [ -d "$HOME/bin" ]; then
    export PATH=$PATH:$HOME/bin
fi

# bin of dotfiles
export PATH=$PATH:$HOME/.dotfiles/bin
