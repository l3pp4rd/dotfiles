#!/bin/sh

# zsh
#rm ~/.zshrc
#ln -s $HOME/.dotfiles/zshrc ~/.zshrc

# $1 source $2 dest $3 question
process_step()
{
    read -p "$3" YN

    if [ "$YN" = "y" ]; then
        echo "Installing $1 to $2"
        if [ -d $2 ]; then
            rm -rf $2
        fi
        if [ -f $2 ]; then
            rm $2
        fi
        ln -s $1 $2
    else
        echo "Skipping $1"
    fi
}

process_step "$HOME/.dotfiles/vim" "$HOME/.vim" ".vim directory will be replaced (Y/n)"
process_step "$HOME/.dotfiles/vimrc" "$HOME/.vimrc" ".vimrc will be replaced (Y/n)"
process_step "$HOME/.dotfiles/git/gitconfig" "$HOME/.gitconfig" ".gitconfig will be replaced (Y/n)"
process_step "$HOME/.dotfiles/git/gitignore" "$HOME/.gitignore" ".gitignore will be replaced (Y/n)"
process_step "$HOME/.dotfiles/zshrc" "$HOME/.zshrc" ".zshrc will be replaced (Y/n)"
process_step "$HOME/.dotfiles/ctags" "$HOME/.ctags" ".ctags will be replaced (Y/n)"
process_step "$HOME/.dotfiles/Xresources" "$HOME/.Xresources" ".Xresources will be replaced (Y/n)"
process_step "$HOME/.dotfiles/xinitrc" "$HOME/.xinitrc" ".xinitrc will be replaced (Y/n)"
if [ -d "$HOME/.xmonad" ]; then
    process_step "$HOME/.dotfiles/xmonad/xmonad.hs" "$HOME/.xmonad/xmonad.hs" ".xmonad/xmonad.hs will be replaced (Y/n)"
fi


