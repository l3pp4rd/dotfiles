#!/bin/sh

xcompmgr > /dev/null &          # turn on transparency
setxkbmap -option ctrl:nocaps   # turn off caps lock key

if [ -d "$HOME/bin" ]; then
    export PATH=$PATH:$HOME/bin
fi

if [ -d "$HOME/go" ]; then
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOPATH/bin
fi
