#!/bin/sh

# current directory
D="$( cd "$( dirname "$0" )" && pwd )"

cd $D

has() {
    TMP=`which $1 2> /dev/null`
    [ $? -eq 0 ]
}

approve () {
    while true; do
        read -p "$1 " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

# $1 source $2 dest
link()
{
    if [ -d "$2" -o -f "$2" ]; then
        if approve "Replace $2 with $1?"; then
            rm -rf $2
            ln -s $1 $2
        fi
    else
        ln -s $1 $2
    fi
}

has "git" || (echo "install git"; exit 1)
# make sure modules are initialized
git submodule update --init
# first check vim availability
has "vim" || (echo "install vim"; exit 1)

if [ ! -d "$HOME/.config" ]; then
    mkdir "$HOME/.config"
fi

# NOTE: powerline installation might require some python packages:
#   psutil, setuptools
# and python version 2.7 or 3.3 or higher
if approve "Install powerline font for airline? (defaults to inconsolata fonts)"; then
    has "wget" || (echo "Install wget to download patched fonts"; exit 1)
    FONT_CONF_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/fontconfig/conf.d"
    if [ ! -d "$FONT_CONF_DIR" ]; then
        mkdir -p "$FONT_CONF_DIR"
    fi
    if [ ! -d "$HOME/.fonts" ]; then
        mkdir "$HOME/.fonts"
    fi
    # download font configuration
    wget -O "$FONT_CONF_DIR/10-powerline-symbols.conf" https://raw.github.com/Lokaltog/powerline/develop/font/10-powerline-symbols.conf
    wget -O "$HOME/.fonts/PowerlineSymbols.otf" https://raw.github.com/Lokaltog/powerline/develop/font/PowerlineSymbols.otf
    # get fixed inconsolata fonts
    wget -O "$HOME/.fonts/Inconsolata.otf" https://raw.github.com/Lokaltog/powerline-fonts/master/Inconsolata/Inconsolata%20for%20Powerline.otf

    # update fonts
    fc-cache -vf ~/.fonts
fi # end powerline font installation

link "$D/scripts" "$HOME/scripts"
link "$D/vim" "$HOME/.vim"
link "$D/vimrc" "$HOME/.vimrc"
link "$D/zshrc" "$HOME/.zshrc"
link "$D/ctags" "$HOME/.ctags"
link "$D/tmux.conf" "$HOME/.tmux.conf"
link "$D/tmux" "$HOME/.tmux"
link "$D/tmuxinator" "$HOME/.tmuxinator"
link "$D/mpd" "$HOME/.mpd"
link "$D/mplayer" "$HOME/.mplayer"
link "$D/ranger" "$HOME/.config/ranger"
link "$D/gemrc" "$HOME/.gemrc"
link "$D/tigrc" "$HOME/.tigrc"
link "$D/gitignore" "$HOME/.gitignore"
link "$D/gitconfig" "$HOME/.gitconfig"

