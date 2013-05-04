#!/bin/sh

# current directory
D="$( cd "$( dirname "$0" )" && pwd )"

# $1 source $2 dest
link()
{
    if [ -d $2 ]; then
        rm -rf $2
    fi
    if [ -f $2 ]; then
        rm $2
    fi
    ln -s $1 $2
}

if [ !-d "$HOME/.config" ]; then
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

