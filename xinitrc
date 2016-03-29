#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# activate ssh agent
eval $(ssh-agent)

# start pulseaudio
pulseaudio --start

# custom key mapping modifications
xmodmap ~/.xmodmap

exec dwm-personalized

