#!/bin/sh

BG_IMG="$HOME/.dotfiles/wallpapers/blue-1920x1080.png"
STATUS="$HOME/.dotfiles/scripts/dwm_status"

xrdb -merge $HOME/.Xresources

xbindkeys &
feh --bg-scale $BG_IMG &        #set the background wallpaper
urxvtd -q -f -o &               # start the rxvt daemon
xsetroot -name "" &             # we have dzen2 status bar
volumeicon &                    # volume icon in systray
mpd &                           # start music player daemon
thunar --daemon &               # start file manager daemon yo hook usb devices
(sleep 0.6 && zsh -c $STATUS) & # run dzen2 status bar, need to make sure wm loads first

# start apps
firefox &                                       # firefox browser
(sleep 0.4 && urxvtc -name 'work' -e tmux) &    # named instance of terminal with tmux(aliased on zsh conf) for work

exec startdwm
