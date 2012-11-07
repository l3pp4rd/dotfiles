#!/bin/sh

xrdb -merge $HOME/.Xresources

xbindkeys &
feh --bg-scale "$HOME/.dotfiles/wallpapers/blue-1920x1080.png" &
urxvtd -q -f -o &
#trayer --widthtype request --align right --SetDockType true --height 18 --transparent true --alpha 0 --tint 0x0B0B0B --margin 190 &
volumeicon &
mpd &
thunar --daemon &

# start apps
#firefox &

# exec startdwm
exec xmonad
