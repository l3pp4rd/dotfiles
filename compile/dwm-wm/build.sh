#!/bin/sh

# current directory
DIR="$( cd "$( dirname "$0" )" && pwd )"

if [ -d "$DIR/dwm" ]; then
    rm -rf $DIR/dwm
fi

# $(hg clone http://hg.suckless.org/dwm ${DIR}/dwm)
cp -r $HOME/c-dev/dwm $DIR/dwm # just copy local version, later will pull from git
cd $DIR

# install
cd dwm
make clean install

