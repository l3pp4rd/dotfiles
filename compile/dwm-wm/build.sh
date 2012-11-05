#!/bin/sh

# current directory
DIR="$( cd "$( dirname "$0" )" && pwd )"

if [ -d "$DIR/dwm" ]; then
    #rm -rf $DIR/dwm
fi

#$(hg clone http://hg.suckless.org/dwm ${DIR}/dwm)
cd $DIR
cp -f config.h dwm/.
cp -f config.mk dwm/.
cd $DIR/dwm

make clean install
# copy binary
cp $DIR/dwm/bin/dwm ~/.dotfiles/bin/dwm

