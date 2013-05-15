#!/usr/bin/env zsh

# making sure all system bin dirs are exported
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin

# bin dir at home
if [ -d "$HOME/bin" ]; then
    export PATH=$PATH:$HOME/bin
fi

# golang
if [ -d "$HOME/go" ]; then
    export GOPATH=$HOME/go # this one for 3rd party
    if [ -d "$HOME/golang" ]; then
        export GOPATH=$GOPATH:$HOME/golang # this one for local development
    fi
    if [ -d "$HOME/go/bin" ]; then
        export GOBIN=$HOME/go/bin # google binary path
        export PATH=$PATH:$GOBIN # export in path as well
    fi
fi

# bin of dotfiles
export PATH=$PATH:$HOME/.dotfiles/bin

# ruby rvm
if [ -d "$HOME/.rvm" ]; then
    export PATH=$PATH:$HOME/.rvm/bin
    source $HOME/.rvm/scripts/rvm
fi
