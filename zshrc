# Path to your oh-my-zsh configuration.
ZSH=$HOME/.dotfiles/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gentoo"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
# --------------PATH---------------
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin
if [ -d "$HOME/bin" ]; then
    export PATH=$PATH:$HOME/bin
fi
# cabal
if [ -d "$HOME/.cabal/bin" ]; then
    export PATH=$PATH:$HOME/.cabal/bin
fi
# scala
if [ -d "$HOME/scala/play/current" ]; then
    export PATH=$PATH:$HOME/scala/play/current
fi
export SBT_OPTS="-Dfile.encoding=UTF8 -Xms512M -Xmx768M -Xss2M -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=512M"

# perl stuff
if [ -d "/usr/bin/vendor_perl" ]; then
    export PATH=$PATH:/usr/bin/core_perl
    export PATH=$PATH:/usr/bin/vendor_perl
fi

# bin of dotfiles
export PATH=$PATH:$HOME/.dotfiles/bin

# go lang
if [ -d "/usr/local/go/bin" ]; then
    export PATH=$PATH:/usr/local/go/bin
    export GOROOT=/usr/local/go
fi

# ruby executables
if [ -d "$HOME/.gem/ruby/1.9.1/bin" ]; then
    export PATH=$PATH:$HOME/.gem/ruby/1.9.1/bin
fi

# bashmarks
if [ -f "$HOME/.dotfiles/extra/bashmarks/bashmarks.sh" ]; then
    source $HOME/.dotfiles/extra/bashmarks/bashmarks.sh
    alias l='l' # is aliased by default to "ls -la" on oh-my-zsh extension
fi

# --------------OTHER--------------
export EDITOR=vim

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

