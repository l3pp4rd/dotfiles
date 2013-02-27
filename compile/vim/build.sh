#!/bin/sh

# current directory
D="$( cd "$( dirname "$0" )" && pwd )"

if [ -d "$D/vim" ]; then
    rm -rf $D/vim
fi

NA=`which hg | grep "not found" | wc -l`
if [ $NA -eq 0 ]; then
    echo "Install mercurial version control aka hg"
    exit 1
fi

$(hg clone hg clone https://vim.googlecode.com/hg/ ${D}/vim)
cd $D/vim

./configure --with-features=huge --disable-largefile --enable-perlinterp --enable-rubyinterp --enable-pythoninterp &&
make &&
sudo make install
