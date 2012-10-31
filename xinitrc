#!/bin/sh

xrdb -merge $HOME/.Xresources

xbindkeys &
feh --bg-scale "$HOME/wallpapers/blue-1920x1080.png" &
urxvtd -q -f -o &
volumeicon &
mpd &
thunar --daemon &

# start apps
firefox &

exec /home/gedi/.cabal/bin/xmonad
