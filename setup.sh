#!/bin/sh

# current directory
D="$( cd "$( dirname "$0" )" && pwd )"

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

if [ ! -d "$HOME/.config" ]; then
    mkdir "$HOME/.config"
fi

link "$D/scripts" "$HOME/scripts"
link "$D/vim" "$HOME/.vim"
link "$D/vimrc" "$HOME/.vimrc"
link "$D/zshrc" "$HOME/.zshrc"
link "$D/ctags" "$HOME/.ctags"
link "$D/Xresources" "$HOME/.Xresources"
link "$D/xinitrc" "$HOME/.xinitrc"
link "$D/tmux.conf" "$HOME/.tmux.conf"
link "$D/tmux" "$HOME/.tmux"
link "$D/tmuxinator" "$HOME/.tmuxinator"
link "$D/mpd" "$HOME/.mpd"
link "$D/ranger" "$HOME/.config/ranger"
link "$D/gemrc" "$HOME/.gemrc"
link "$D/tigrc" "$HOME/.tigrc"
link "$D/gitignore" "$HOME/.gitignore"
link "$D/gitconfig" "$HOME/.gitconfig"

