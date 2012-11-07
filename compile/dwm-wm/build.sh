#!/bin/sh

# current directory
DIR="$( cd "$( dirname "$0" )" && pwd )"

if [ -d "$DIR/dwm" ]; then
    rm -rf $DIR/dwm
fi

$(hg clone http://hg.suckless.org/dwm ${DIR}/dwm)
cd $DIR

# apply configs
cp -f config.h dwm/.
cp -f config.mk dwm/.

# apply patches
patch dwm/dwm.c patches/6.1.trayer.patch.diff

# install
cd dwm
make clean install
# copy binary
if [ -f "$DIR/dwm/bin/dwm" ]; then
    cp $DIR/dwm/bin/dwm ~/.dotfiles/bin/dwm
fi

