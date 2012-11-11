#!/bin/sh

BG_IMG="$HOME/.dotfiles/wallpapers/blue-1920x1080.png"
STATUS="$HOME/.dotfiles/scripts/dwm_status"

xrdb -merge $HOME/.Xresources

xbindkeys &
feh --bg-scale $BG_IMG &    #set the background wallpaper
urxvtd -q -f -o &           # start the rxvt daemon
xsetroot -name "" &         # we have dzen2 status bar
volumeicon &                # volume icon in systray
mpd &                       # start music player daemon
thunar --daemon &           # start file manager daemon yo hook usb devices
zsh -c $STATUS &            # run dzen2 status bar

# start apps
#firefox &

exec startdwm
