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

if approve "Install powerline ?"; then
    if [ -z "$XDG_CONFIG_HOME" ]; then
        echo "export XDG_CONFIG_HOME for powerline fonts to be configured"
        exit 1
    else
        if [ ! -d "$XDG_CONFIG_HOME/fontconfig/conf.d" ]; then
            mkdir -p "$XDG_CONFIG_HOME/fontconfig/conf.d"
        fi
        if [ ! -d "$HOME/.fonts" ]; then
            mkdir "$HOME/.fonts"
        fi
        if [ ! -d "$D/vim/plugin" ]; then
            mkdir "$D/vim/plugin"
        fi
        link "$D/powerline/font/10-powerline-symbols.conf" "$XDG_CONFIG_HOME/fontconfig/conf.d/10-powerline-symbols.conf"
        link "$D/powerline/font/PowerlineSymbols.otf" "$HOME/.fonts/PowerlineSymbols.otf"
        link "$D/powerline/powerline/bindings/vim/plugin/powerline.vim" "$D/vim/plugin/powerline.vim"
        link "$D/powerline/powerline/bindings/zsh/powerline.zsh" "$D/zsh/powerline.zsh"
        link "$D/powerline/powerline/bindings/tmux/powerline.conf" "$D/tmux/powerline.conf"

        # get fixed inconsolata fonts
        wget -O ~/.fonts/Inconsolata.otf https://raw.github.com/Lokaltog/powerline-fonts/master/Inconsolata/Inconsolata%20for%20Powerline.otf

        PY3=$(vim --version | grep -c '+python3')
        PY2=$(vim --version | grep -c '+python')
        CMD="setup.py install --optimize=1"
        cd $D/powerline
        # guess python executables
        if [ $PY3 -eq 1 ]; then
            has "python3" && (sudo python3 $CMD || (has "python" && sudo python $CMD) || echo "Failed to run setup.py")
        elif [ $PY2 -eq 1 ]; then
            has "python2" && (sudo python2 $CMD || (has "python" && sudo python $CMD) || echo "Failed to run setup.py")
        else
            echo "in order to install powerline - vim should be compiled with python support"
            exit 1
        fi
        # update fonts
        fc-cache -vf ~/.fonts
    fi
fi # end powerline installation

link "$D/scripts" "$HOME/scripts"
link "$D/vim" "$HOME/.vim"
link "$D/vimrc" "$HOME/.vimrc"
link "$D/zshrc" "$HOME/.zshrc"
link "$D/ctags" "$HOME/.ctags"
link "$D/tmux.conf" "$HOME/.tmux.conf"
link "$D/tmux" "$HOME/.tmux"
link "$D/tmuxinator" "$HOME/.tmuxinator"
link "$D/mpd" "$HOME/.mpd"
link "$D/ranger" "$HOME/.config/ranger"
link "$D/gemrc" "$HOME/.gemrc"
link "$D/tigrc" "$HOME/.tigrc"
link "$D/gitignore" "$HOME/.gitignore"
link "$D/gitconfig" "$HOME/.gitconfig"

