#!/usr/bin/env zsh

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin
if [ -d "$HOME/bin" ]; then
    export PATH=$PATH:$HOME/bin
fi
# cabal
if [ -d "$HOME/.cabal/bin" ]; then
    export PATH=$PATH:$HOME/.cabal/bin
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

# ruby executables
if [ -d "$HOME/.gem/ruby/1.9.1/bin" ]; then
    export PATH=$PATH:$HOME/.gem/ruby/1.9.1/bin
fi
