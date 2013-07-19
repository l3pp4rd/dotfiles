#!/bin/sh

BG_IMG="$HOME/.dotfiles/wallpapers/blue-1920x1080.png"

xrdb -merge $HOME/.Xresources   # custom URxvt configurations and colorization

xset m 2/3 2 &                  # set mouse sensitivity
setxkbmap -option ctrl:nocaps & # disable caps lock
xbindkeys &                     # extra key mappings
feh --bg-scale $BG_IMG &        # set the background wallpaper
xsetroot -name "" &             # we have dzen2 status bar, set main WM window title to none
mpd &                           # start music player daemon
devmon &                        # automount removable devices
thunar --daemon &               # start file manager daemon yo hook usb devices

exec startdwm

