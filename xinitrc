#!/bin/sh

xrdb -merge $HOME/.Xresources

feh --bg-scale "$HOME/wallpapers/blue-1920x1080.png" &
#volumeicon &
#tidybattery &

exec openbox-session
