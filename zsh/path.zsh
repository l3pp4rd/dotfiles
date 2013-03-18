#!/usr/bin/env zsh

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin
if [ -d "$HOME/bin" ]; then
    export PATH=$PATH:$HOME/bin
fi
# go
if [ -d "$HOME/go" ]; then
    export GOPATH=$HOME/go
fi
# scala
if [ -d "$HOME/scala/play" ]; then
    export PATH=$PATH:$HOME/scala/play
fi

# perl stuff
if [ -d "/usr/bin/vendor_perl" ]; then
    export PATH=$PATH:/usr/bin/core_perl
    export PATH=$PATH:/usr/bin/vendor_perl
fi

# bin of dotfiles
export PATH=$PATH:$HOME/.dotfiles/bin

